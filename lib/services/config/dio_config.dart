import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

import '../../utils/utils.dart';

/// A class that provides a configuration for Dio HTTP client to interact with the Marvel API.
class DioConfig {
  // Generate the current date without spaces to be used in the API request.
  static final _date = DateTime.now().toString().split(' ').join('');

  // Create a Dio instance with the base URL and other configurations for Marvel API requests.
  static final dio = Dio(BaseOptions(
    baseUrl: 'http://gateway.marvel.com',
    validateStatus: (_) => true,
    queryParameters: {
      // Include the current timestamp in the request
      'ts': _date,
      // Include the public API key
      'apikey': Environment.apiKeyPublic,
      // Generate and include the hash for authentication
      'hash': _generateHash(),
    },
  ));

  /// Generates a hash for authentication using the current timestamp and API keys.
  static String _generateHash() {
    final hash =
        '$_date${Environment.apiKeyPrivate}${Environment.apiKeyPublic}'; // Concatenate the timestamp and API keys
    return md5
        .convert(utf8.encode(hash))
        .toString(); // Calculate the MD5 hash of the concatenated string
  }
}
