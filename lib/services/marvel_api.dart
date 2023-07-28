import '../models/models.dart';
import 'config/dio_config.dart';

class MarvelApi extends DioConfig {
  final dio = DioConfig.dio;
  Future<List<ComicModel>> getComics() async {
    try {
      final response = await dio.get('/v1/public/comics?limit=99');
      if (response.statusCode == 200) {
        return (response.data['data']['results'] as List)
            .map((comic) => ComicModel.fromJson(comic))
            .toList();
      } else {
        throw Exception(response.data.toString());
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CharacterModel>> getCharacters(String id) async {
    try {
      final response = await dio.get('/v1/public/comics/$id/characters');
      if (response.statusCode == 200) {
        return (response.data['data']['results'] as List)
            .map((character) => CharacterModel.fromJson(character))
            .toList();
      } else {
        throw Exception(response.data.toString());
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ComicModel>> searchComics(String query) async {
    try {
      final response =
          await dio.get('/v1/public/comics?titleStartsWith=$query&limit=99');
      if (response.statusCode == 200) {
        return (response.data['data']['results'] as List)
            .map((comic) => ComicModel.fromJson(comic))
            .toList();
      } else {
        throw Exception(response.data.toString());
      }
    } catch (e) {
      rethrow;
    }
  }
}
