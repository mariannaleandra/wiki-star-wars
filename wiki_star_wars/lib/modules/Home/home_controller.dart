import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wiki_star_wars/models/character.dart';
import 'package:wiki_star_wars/repositories/character_repository.dart';

class HomeController extends GetxController {
  final CharacterRepository _characterRepository;
  HomeController(this._characterRepository);

  final pagingCharacters = PagingController<int, Character>(firstPageKey: 1);

  final RxBool _inAsyncCall = false.obs;
  bool get inAsyncCall => _inAsyncCall.value;

  final int pageSize = 10;

  @override
  void onInit() {
    super.onInit();
    pagingCharacters.appendLastPage([]);
    pagingCharacters
        .addPageRequestListener(onPageCharactersFetch(pagingCharacters));
    loadCharacters();
  }

  Future<void> loadCharacters() async {
    _inAsyncCall.value = true;
    await _loadPageCharacters(pagingCharacters);
    _inAsyncCall.value = false;
  }

  Future<void> _loadPageCharacters(
      final PagingController<int, Character> pagingController) async {
    final newItensUsers = await _characterRepository.listCharacters();

    final characters = newItensUsers.results;

    pagingController
      ..itemList = characters
      ..nextPageKey = 2;
  }

  Future<void> Function(int) onPageCharactersFetch(
          final PagingController<int, Character> pagingController) =>
      (final int pageKey) async {
        final newPage =
            await _characterRepository.listCharacters(page: pageKey);

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
}
