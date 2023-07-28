import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/models.dart';
import 'marvel_api_provider.dart';

final listComicProvider =
    StateNotifierProvider<ComicNotifier, List<ComicModel>>(
        (ref) => ComicNotifier(ref: ref));

class ComicNotifier extends StateNotifier<List<ComicModel>> {
  ComicNotifier({required this.ref}) : super([]);

  final StateNotifierProviderRef ref;
  bool isLoading = false;

  Future<void> getComics() async {
    try {
      isLoading = true;
      final comics = await ref.read(marvelApiProvider).getComics();
      isLoading = false;
      state = comics;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> onRefresh() async {
    try {
      final comics = await ref.read(marvelApiProvider).getComics();
      state = [];
      await Future.delayed(const Duration(milliseconds: 100));
      state = comics;
    } catch (e) {
      rethrow;
    }
  }
}
