import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../widgets/comic/comic_card.dart';
import '../views.dart';

typedef SearchComicCallback = Future<List<ComicModel>> Function(String query);
typedef ComicsStream = StreamController<List<ComicModel>>;

class SearchComicDelegate extends SearchDelegate<ComicModel?> {
  SearchComicDelegate({required this.searchComicByQuery})
      : super(searchFieldLabel: 'Buscar comics');

  SearchComicCallback searchComicByQuery;
  List<ComicModel> initialData = [];

  ComicsStream debounceComics = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();
  Timer? _debounceTimer;

  void clearStreams() {
    debounceComics.close();
  }

  void _onQueryChanged(String query) {
    if (query.isNotEmpty) isLoadingStream.add(true);
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final comics = await searchComicByQuery(query);
      initialData.addAll(comics);
      debounceComics.add(comics);
      isLoadingStream.add(false);
    });
  }

  Widget _buildResultsAndSuggestions() {
    return StreamBuilder<List<ComicModel>>(
      initialData: initialData,
      stream: debounceComics.stream,
      builder: (context, snapshot) {
        final comics = snapshot.data ?? [];

        if (comics.isEmpty) {
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
                  'No se encontraron resultados',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: comics.length,
          itemBuilder: (context, index) {
            final comic = comics[index];
            final image =
                '${comic.thumbnail!.path!}/portrait_xlarge.${comic.thumbnail!.exten!.name.toLowerCase()}';
            return GestureDetector(
              onTap: () {
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
            return SpinPerfect(
              duration: const Duration(seconds: 20),
              infinite: true,
              spins: 10,
              child: const Icon(Icons.refresh_rounded),
            );
          }
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
    return _buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return _buildResultsAndSuggestions();
  }
}
