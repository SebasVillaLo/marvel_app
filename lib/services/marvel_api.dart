import '../models/models.dart';
import 'config/dio_config.dart';

class MarvelApi extends DioConfig {
  final dio = DioConfig.dio;
  Future<List<ComicsModel>> getComics() async {
    try {
      final response = await dio.get('/v1/public/comics');
      if (response.statusCode == 200) {
        return (response.data['data']['results'] as List)
            .map((e) => ComicsModel.fromJson(e))
            .toList();
      } else {
        throw Exception('Error al obtener los datos');
      }
    } catch (e) {
      rethrow;
    }
  }
}
