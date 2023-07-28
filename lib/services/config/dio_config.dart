import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

import '../../utils/utils.dart';

class DioConfig {
  static final _date = DateTime.now().toString().split(' ').join('');
  static final dio = Dio(BaseOptions(
    baseUrl: 'http://gateway.marvel.com',
    validateStatus: (_) => true,
    queryParameters: {
      'ts': _date,
      'apikey': Environment.apiKeyPublic,
      'hash': _generateHash(),
    },
  ));

  static String _generateHash() {
    final hash =
        '$_date${Environment.apiKeyPrivate}${Environment.apiKeyPublic}';
    return md5.convert(utf8.encode(hash)).toString();
  }
}
