import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/models.dart';
import '../providers.dart';

/// Riverpod state notifier provider that manages a list of comic models for search results.
final searchedComicsProvider =
    StateNotifierProvider<SearchComicNotifier, List<ComicModel>>((ref) {
  return SearchComicNotifier(ref: ref);
});

/// Callback function signature to search for comics.
typedef SearchComicCallback = Future<List<ComicModel>> Function(String query);

/// A StateNotifier that handles a list of comic models for search results.
class SearchComicNotifier extends StateNotifier<List<ComicModel>> {
  /// Constructor for SearchComicNotifier.
  SearchComicNotifier({required this.ref}) : super([]);

  /// Reference to the Ref object for dependency injection.
  final Ref ref;

  /// Asynchronously searches for comics using the provided query.
  /// Returns a list of comic models that match the search criteria.
  Future<List<ComicModel>> searchComicByQuery(String query) async {
    // Call the searchComics method of the Marvel API provider to fetch comics that match the query
    final List<ComicModel> comics =
        await ref.read(marvelApiProvider).searchComics(query);
    state = comics;
    return comics;
  }
}
