import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wiki_star_wars/models/character.dart';
import 'package:wiki_star_wars/repositories/character_repository.dart';

class HomeController extends GetxController {
  final CharacterRepository _characterRepository;
  HomeController(this._characterRepository);

  final pagingCharacters = PagingController<int, Character>(firstPageKey: 1);

  final int pageSize = 10;

  String _searchText = '';

  @override
  void onInit() {
    super.onInit();
    pagingCharacters.appendLastPage([]);
    pagingCharacters
        .addPageRequestListener(fetchPageCharacters(pagingCharacters));
    pagingCharacters.refresh();
  }

  Future<void> Function(int) fetchPageCharacters(
          final PagingController<int, Character> pagingController) =>
      (final int pageKey) async {
        final newPage = await _characterRepository.listCharacters(
          page: pageKey,
          search: _searchText,
        );

        final newCharacters = newPage.results;

        if (newCharacters.length < pageSize) {
          pagingController.appendLastPage(newCharacters);
        } else {
          pagingController.appendPage(newCharacters, pageKey + 1);
        }
      };

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
