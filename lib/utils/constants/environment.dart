import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String apiKeyPublic = dotenv.env['API_KEY_PUBLIC'] ?? 'No hay key';
  static String apiKeyPrivate = dotenv.env['API_KEY_PRIVATE'] ?? 'No hay key';
}
