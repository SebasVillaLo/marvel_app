import '../models/models.dart';
import 'config/dio_config.dart';

/// A class that interacts with the Marvel API to fetch comic and character data.
class MarvelApi extends DioConfig {
  final dio = DioConfig.dio;

  /// Asynchronously fetches a list of comic models from the Marvel API.
  /// Returns a list of ComicModel.
  Future<List<ComicModel>> getComics() async {
    try {
      final response = await dio
          .get('/v1/public/comics?limit=99'); // API call to fetch comics
      if (response.statusCode == 200) {
        // Parse the response and convert the data to a list of ComicModel
        return (response.data['data']['results'] as List)
            .map((comic) => ComicModel.fromJson(comic))
            .toList();
      } else {
        // Throw an exception with the response data if the request was not successful
        throw Exception(response.data.toString());
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Asynchronously fetches a list of character models from the Marvel API based on the provided comic ID.
  /// Returns a list of CharacterModel.
  Future<List<CharacterModel>> getCharacters(String id) async {
    try {
      final response = await dio.get(
          '/v1/public/comics/$id/characters');
      if (response.statusCode == 200) {
        // Parse the response and convert the data to a list of CharacterModel
        return (response.data['data']['results'] as List)
            .map((character) => CharacterModel.fromJson(character))
            .toList();
      } else {
        // Throw an exception with the response data if the request was not successful
        throw Exception(response.data.toString());
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Asynchronously searches for comics from the Marvel API based on the provided query.
  /// Returns a list of ComicModel that match the search criteria.
  Future<List<ComicModel>> searchComics(String query) async {
    try {
      final response = await dio.get(
          '/v1/public/comics?titleStartsWith=$query&limit=99');
      if (response.statusCode == 200) {
        // Parse the response and convert the data to a list of ComicModel
        return (response.data['data']['results'] as List)
            .map((comic) => ComicModel.fromJson(comic))
            .toList();
      } else {
        // Throw an exception with the response data if the request was not successful
        throw Exception(response.data.toString());
      }
    } catch (e) {
      rethrow;
    }
  }
}
