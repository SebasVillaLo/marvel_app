import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/marvel_api.dart';

final marvelApiProvider = Provider<MarvelApi>((ref) {
  return MarvelApi();
});
