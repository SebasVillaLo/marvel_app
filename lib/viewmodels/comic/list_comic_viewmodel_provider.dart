import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/models.dart';
import 'marvel_api_viewmodel_provider.dart';

final listComicViewModelProvider =
    StateNotifierProvider<ComicNotifier, List<ComicsModel>>(
        (ref) => ComicNotifier(ref: ref));

class ComicNotifier extends StateNotifier<List<ComicsModel>> {
  ComicNotifier({required this.ref}) : super([]);

  final StateNotifierProviderRef ref;

  Future<void> getComics() async {
    try {
      final comics = await ref.read(marvelApiProvider).getComics();
      state = comics;
    } catch (e) {
      rethrow;
    }
  }
}
