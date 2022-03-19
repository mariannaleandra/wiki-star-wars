import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ApiBase {
  late Dio client;

  ApiBase() {
    final opts = BaseOptions(
      connectTimeout: 15000,
      contentType: 'application/json',
    );

    client = Dio(opts);

    client.interceptors
        .add(InterceptorsWrapper(onRequest: (final options, final handler) {
      // Logs Api requests
      var msg = '**********API REQUEST**********\n';
      msg += 'Request: ${options.uri} \n';
      msg += 'Method: ${options.method}';
      // msg += options.data != null ? '\nBody: ${options.data}' : '';
      msg += '\n********************************';
      debugPrint(msg);
      return handler.next(options);
    }, onResponse: (final resp, final handler) {
      // Logs Api reponse
      var msg = '**********API RESPONSE**********\n';
      msg += 'Response: ${resp.requestOptions.uri}\n';
      msg +=
          'Method: ${resp.requestOptions.method} - Status: ${resp.statusCode}';
      // msg += resp.data != null ? '\nBody: ${resp.data}' : '';
      msg += '\n*********************************';
      debugPrint(msg);

      return handler.next(resp);
    }, onError: (final DioError e, final handler) {
      try {
        var data = <String, dynamic>{};
        if (e.response?.data.runtimeType == String) {
          data = jsonDecode(e.response?.data) ?? {};
        }

        if (e.response != null) {
          final String errorMsg = data['error'] ??
              e.response?.statusMessage ??
              '${e.response?.data}';
          debugPrint(
              '[ERROR] :: onError :: ${e.response?.requestOptions.method} ${e.response?.requestOptions.uri} - ${e.response?.statusCode} $errorMsg');
        }
      } on Exception catch (err) {
        if (e.response?.data?.runtimeType == String) {
          debugPrint('[ERROR] :: onError :: $err :: ${e.response?.data}');
        } else {
          debugPrint('[ERROR] :: onError :: $err');
        }
      }
      // next
      return handler.next(e);
    }));
  }
}
