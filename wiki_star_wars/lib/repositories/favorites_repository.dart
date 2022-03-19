import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wiki_star_wars/constants/api_constants.dart';
import 'package:wiki_star_wars/provider/api.dart';

class FavoriteRepository extends ApiBase {
  bool lastFailed = true;

  Future<String> favorite({required String id}) async {
    var headers = <String, dynamic>{};

    if (!lastFailed) {
      headers = {
        'Prefer': 'status=400',
      };
    }

    try {
      final response = await client.post(
        '${ApiConstants.BASE_URL_FAVORITE}/favorite/$id',
        options: headers.isNotEmpty ? Options(headers: headers) : null,
      );
      final data = response.data;

      if (response.statusCode == 201 && data != null) {
        lastFailed = false;
        return data['message'];
      }
    } on DioError catch (e) {
      debugPrint('[ERROR] :: error trying to add to favorite :: ${e.response}');
      lastFailed = true;
      return e.response?.data['error_message'];
    }
    return 'error';
  }
}
