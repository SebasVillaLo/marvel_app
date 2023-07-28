import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

import '../../utils/utils.dart';

class DioConfig {
  static final _date = DateTime.now();
  static final dio = Dio(BaseOptions(
    baseUrl: 'http://gateway.marvel.com',
    queryParameters: {
      'ts': _date,
      'api_key': Environment.apiKeyPublic,
      'hash': _generateHash(),
      'lenguage': 'es-MX',
    },
  ));

  static String _generateHash() {
    final hash =
        '$_date${Environment.apiKeyPrivate}${Environment.apiKeyPublic}';
    return md5.convert(utf8.encode(hash)).toString();
  }
}
