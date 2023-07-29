import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/models.dart';
import 'marvel_api_provider.dart';

final listComicProvider =
    StateNotifierProvider<ComicNotifier, List<ComicModel>>(
  (ref) => ComicNotifier(ref: ref),
);

/// A StateNotifier that handles a list of comic models.
class ComicNotifier extends StateNotifier<List<ComicModel>> {
  ComicNotifier({required this.ref}) : super([]);

  /// Reference to the StateNotifierProviderRef for dependency injection.
  final StateNotifierProviderRef ref;

  /// Flag to indicate whether the data is currently being loaded.
  bool isLoading = false;

  /// Asynchronously fetches comics from the Marvel API.
  Future<void> getComics() async {
    try {
      isLoading = true;
      /// Fetch comics from the Marvel API
      final comics = await ref
          .read(marvelApiProvider)
          .getComics(); 
      isLoading = false;
      state = comics;
    } catch (e) {
      rethrow;
    }
  }

  // Asynchronously fetches comics from the Marvel API on refresh.
  Future<void> onRefresh() async {
    try {
      // Fetch comics from the Marvel API
      final comics = await ref.read(marvelApiProvider).getComics();
      state = [];
      // Simulate a short delay for a smooth refresh animation
      await Future.delayed(const Duration(milliseconds: 100));
      state = comics;
    } catch (e) {
      rethrow;
    }
  }
}
