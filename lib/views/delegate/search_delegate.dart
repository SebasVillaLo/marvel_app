import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../widgets/comic/comic_card.dart';
import '../views.dart';

// Custom callback function signature to search for comics
typedef SearchComicCallback = Future<List<ComicModel>> Function(String query);

// Custom stream controller type for a list of ComicModel
typedef ComicsStream = StreamController<List<ComicModel>>;

/// A delegate to handle searching for comics using Flutter's search functionality.
class SearchComicDelegate extends SearchDelegate<ComicModel?> {
  // Constructor to receive a search callback function
  SearchComicDelegate({required this.searchComicByQuery})
      : super(searchFieldLabel: 'Search comics'); // Super constructor call

  // Callback function to search for comics
  SearchComicCallback searchComicByQuery;

  // List to hold initial data for search results
  List<ComicModel> initialData = [];

  // StreamController to debounce search queries
  ComicsStream debounceComics = StreamController.broadcast();

  // StreamController to handle loading state
  StreamController<bool> isLoadingStream = StreamController.broadcast();

  // Timer used for debouncing search queries
  Timer? _debounceTimer;

  /// Method to clear stream controllers when not needed anymore
  void clearStreams() {
    debounceComics.close();
  }

  /// Method that gets called whenever the user types in the search field
  void _onQueryChanged(String query) {
    if (query.isEmpty) return; // if query is empty, do nothing
    if (query.isNotEmpty) isLoadingStream.add(true); // Notify loading started

    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel(); // Cancel existing timer if any
    }

    // Set a debounce timer to wait for 500 milliseconds before executing the search
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      // Perform the actual search
      final comics = await searchComicByQuery(query);

      // Add the search results to the initial data list and notify the debounced stream
      initialData.addAll(comics);
      debounceComics.add(comics);

      isLoadingStream.add(false); // Notify loading finished
    });
  }

  /// Builds the search results and suggestions based on the debounced stream
  Widget _buildResultsAndSuggestions() {
    return StreamBuilder<List<ComicModel>>(
      initialData: initialData,
      stream: debounceComics.stream,
      builder: (context, snapshot) {
        final comics = snapshot.data ?? [];

        if (comics.isEmpty) {
          // Show no results message if no comics found
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off_rounded,
                  size: 100,
                ),
                SizedBox(height: 10),
                Text(
                  'No results found',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          );
        }

        // Show the list of comics using ListView.builder
        return ListView.builder(
          itemCount: comics.length,
          itemBuilder: (context, index) {
            final comic = comics[index];
            final image =
                '${comic.thumbnail!.path!}/portrait_xlarge.${comic.thumbnail!.exten!.name.toLowerCase()}';
            return GestureDetector(
              onTap: () {
                // Navigate to the ComicDetail page when a comic is tapped
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return ComicDetail(
                    comic: comic,
                  );
                }));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: FadeIn(
                  child: ComicCard(
                    comic: comic,
                    image: image,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        stream: isLoadingStream.stream,
        initialData: false,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            // Show a loading spinner while searching
            return SpinPerfect(
              duration: const Duration(seconds: 20),
              infinite: true,
              spins: 10,
              child: const Icon(Icons.refresh_rounded),
            );
          }
          // Show a clear icon to reset the search query
          return FadeIn(
            animate: query.isNotEmpty,
            duration: const Duration(milliseconds: 200),
            child: IconButton(
              onPressed: () {
                query = '';
              },
              icon: const Icon(Icons.clear),
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // Show a back button in the leading position to exit the search
    return IconButton(
      onPressed: () {
        clearStreams();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Build the search results page
    return _buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Call the _onQueryChanged method to handle the search
    _onQueryChanged(query);
    return _buildResultsAndSuggestions();
  }
}
