import 'dart:io';

import 'package:flutter/foundation.dart';

class InternetUtils {
  static Future<bool> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (e) {
      debugPrint('[WARNING] :: no connection :: $e');
    }
    return false;
  }
}
