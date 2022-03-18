import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wiki_star_wars/models/character.dart';
import 'package:wiki_star_wars/repositories/character_repository.dart';
import 'package:wiki_star_wars/utils/internet_utils.dart';
import 'package:wiki_star_wars/utils/storage_utils.dart';

class HomeController extends GetxController {
  final CharacterRepository _characterRepository;
  HomeController(this._characterRepository);

  final pagingCharacters = PagingController<int, Character>(firstPageKey: 1);

  final int pageSize = 10;

  String _searchText = '';

  @override
  void onInit() {
    super.onInit();
    pagingCharacters
        .addPageRequestListener((pageKey) => _fetchPageCharacters(pageKey));
  }

  Future<List<Character>> _readData() async {
    final content = await StorageUtils.readcontent();
    Iterable l = jsonDecode(content);
    final list =
        List<Character>.from(l.map((model) => Character.fromJson(model)));
    return list;
  }

  Future<void> _fetchPageCharacters(int pageKey) async {
    bool firstLoad = pageKey == 1;
    try {
      final hasConnection = await InternetUtils.checkConnection();

      if (hasConnection) {
        var newPage = await _characterRepository.listCharacters(
          page: pageKey,
          search: _searchText,
        );

        final newCharacters = newPage.results;

        if (newCharacters.length < pageSize) {
          pagingCharacters.appendLastPage(newCharacters);
        } else {
          pagingCharacters.appendPage(newCharacters, pageKey + 1);
        }

        if (firstLoad) {
          //reload file data on first reload
          StorageUtils.writeContent(content: jsonEncode(newCharacters));
        }
      } else if (firstLoad) {
        pagingCharacters
          ..itemList = await _readData()
          ..nextPageKey = 2;
        throw Exception('no internet connection');
      } else {
        throw Exception('no internet connection');
      }
    } on Exception catch (error) {
      pagingCharacters.error = error;
    }
  }

  void onPressCharacter(Character character) {
    //TODO
    debugPrint('[DEBUG] :: on pressed ${character.name}');
  }

  void onSearch(String value) {
    _searchText = value;
    pagingCharacters.refresh();
  }

  @override
  void onClose() {
    pagingCharacters.dispose();
    super.onClose();
  }
}
