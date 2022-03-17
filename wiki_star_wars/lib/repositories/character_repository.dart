import 'package:flutter/foundation.dart';
import 'package:wiki_star_wars/models/character.dart';
import 'package:wiki_star_wars/models/page.dart';
import 'package:wiki_star_wars/provider/api.dart';

class CharacterRepository extends ApiBase {
  Future<Page<Character>> listCharacters(
      {int? page = 1, String search = ''}) async {
    final Map<String, dynamic> params = {
      'page': page,
    };

    if (search.isNotEmpty) {
      params.putIfAbsent('search', () => search);
    }

    try {
      final response = await client.get('people', queryParameters: params);
      final data = response.data;

      if (response.statusCode == 200 && data != null) {
        return Page<Character>.fromJson(
            data, (final json) => Character.fromJson(json));
      }
    } on Exception catch (e) {
      debugPrint('[ERROR] :: error trying to list characters :: $e');
    }

    return Page.empty();
  }
}
