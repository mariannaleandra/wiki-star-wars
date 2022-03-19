import 'dart:io';

import 'package:path_provider/path_provider.dart';

class StorageUtils {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> _localFile(String fileName) async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  static Future<void> writeContent(
      {String content = '[]', required String storage}) async {
    final file = await _localFile(storage);
    await file.writeAsString(content);
  }

  static Future<String> readcontent({required String storage}) async {
    final file = await _localFile(storage);
    String content = await file.readAsString();
    return content;
  }
}
