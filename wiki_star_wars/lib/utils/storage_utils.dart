import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class StorageUtils {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> _localFile(String fileName) async {
    final path = await _localPath;
    return File('$path/$fileName.txt');
  }

  static Future<void> writeContent(
      {String content = '[]', String name = 'data'}) async {
    try {
      final file = await _localFile(name);
      await file.writeAsString(content);
    } on Exception catch (e) {
      debugPrint('[ERROR] :: error trying to WRITE content in file :: $e');
    }
  }

  static Future<String> readcontent({String name = 'data'}) async {
    try {
      final file = await _localFile(name);
      String content = await file.readAsString();
      return content;
    } on Exception catch (e) {
      debugPrint('[ERROR] :: error trying to READ content from file :: $e');
      return 'Error trying to read content';
    }
  }
}
