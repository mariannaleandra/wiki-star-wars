import 'package:flutter/foundation.dart';
import 'package:wiki_star_wars/constants/api_constants.dart';
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
      final response = await client.get(
          '${ApiConstants.BASE_URL_CHARACTER}/people',
          queryParameters: params);
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

  Future<String> getHomeworldName({required String url}) async {
    try {
      final response = await client.get(url);
      final data = response.data;

      if (response.statusCode == 200 && data != null) {
        return data['name'];
      }
    } on Exception catch (e) {
      debugPrint('[ERROR] :: error trying to get homeworld :: $e');
    }
    return '';
  }

  Future<List<String>> getSpeciesNames({required List<String> urls}) async {
    var speciesNames = <String>[];
    try {
      for (int i = 0; i < urls.length; ++i) {
        final response = await client.get(urls[i]);
        final data = response.data;

        if (response.statusCode == 200 && data != null) {
          speciesNames.add(data['name']);
        }
      }
    } on Exception catch (e) {
      debugPrint('[ERROR] :: error trying to get species :: $e');
    }
    return speciesNames;
  }
}
