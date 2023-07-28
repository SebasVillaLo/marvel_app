import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/models.dart';
import '../providers.dart';

final searchedComicsProvider =
    StateNotifierProvider<SearchComicNotifier, List<ComicModel>>((ref) {
  return SearchComicNotifier(ref: ref);
});

typedef SearchComicCallback = Future<List<ComicModel>> Function(String query);

class SearchComicNotifier extends StateNotifier<List<ComicModel>> {
  SearchComicNotifier({required this.ref}) : super([]);

  final Ref ref;
  Future<List<ComicModel>> searchComicByQuery(String query) async {
    final List<ComicModel> comics =
        await ref.read(marvelApiProvider).searchComics(query);
    state = comics;
    return comics;
  }
}
