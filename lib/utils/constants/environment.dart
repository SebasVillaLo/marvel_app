import 'package:flutter_dotenv/flutter_dotenv.dart';

/// A class that provides access to environment variables.
class Environment {
  /// The public API key obtained from the environment variables.
  static String apiKeyPublic = dotenv.env['API_KEY_PUBLIC'] ?? 'No hay key';

  /// The private API key obtained from the environment variables.
  static String apiKeyPrivate = dotenv.env['API_KEY_PRIVATE'] ?? 'No hay key';
}
