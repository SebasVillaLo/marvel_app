import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/models.dart';
import 'marvel_api_provider.dart';

/// Riverpod state notifier provider that manages a list of character models.
final listCharacterProvider =
    StateNotifierProvider.autoDispose<CharacterNotifier, List<CharacterModel>>(
  (ref) => CharacterNotifier(ref: ref),
);

/// A StateNotifier that handles a list of character models.
class CharacterNotifier extends StateNotifier<List<CharacterModel>> {
  /// Constructor for CharacterNotifier.
  CharacterNotifier({required this.ref}) : super([]);

  /// Reference to the StateNotifierProviderRef for dependency injection.
  final StateNotifierProviderRef ref;

  /// Flag to indicate whether the data is currently being loaded.
  bool isLoading = false;

  /// Asynchronously fetches comics for a character with the given ID.
  Future<void> getComics(String id) async {
    try {
      isLoading = true;
      // Call the Marvel API provider to fetch characters
      final character = await ref.read(marvelApiProvider).getCharacters(id);
      isLoading = false;
      state = character;
    } catch (e) {
      rethrow;
    }
  }
}
