import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/models.dart';
import 'marvel_api_provider.dart';

final listCharacterProvider =
    StateNotifierProvider.autoDispose<CharacterNotifier, List<CharacterModel>>(
        (ref) => CharacterNotifier(ref: ref));

class CharacterNotifier extends StateNotifier<List<CharacterModel>> {
  CharacterNotifier({required this.ref}) : super([]);

  final StateNotifierProviderRef ref;
  bool isLoading = false;

  Future<void> getComics(String id) async {
    try {
      isLoading = true;
      final character = await ref.read(marvelApiProvider).getCharacters(id);
      isLoading = false;
      state = character;
    } catch (e) {
      rethrow;
    }
  }
}
