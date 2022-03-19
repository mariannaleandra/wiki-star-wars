import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wiki_star_wars/models/character.dart';
import 'package:wiki_star_wars/models/favorites.dart';
import 'package:wiki_star_wars/repositories/character_repository.dart';
import 'package:wiki_star_wars/repositories/favorites_repository.dart';
import 'package:wiki_star_wars/utils/internet_utils.dart';
import 'package:wiki_star_wars/utils/storage_utils.dart';

class HomeController extends GetxController {
  final CharacterRepository _characterRepository;
  final FavoriteRepository _favoriteRepository;
  HomeController(this._characterRepository, this._favoriteRepository);

  final pagingCharacters = PagingController<int, Character>(firstPageKey: 1);

  final _selectedCharacter = Character.empty().obs;
  Character get selectedCharacter => _selectedCharacter.value;

  final int pageSize = 10;

  String _searchText = '';

  final _asyncCallMsg = ''.obs;
  String get loadingMsg => _asyncCallMsg.value;
  bool get isLoading => _asyncCallMsg.value.isNotEmpty;

  final _favorites = Favorites.empty().obs;
  List<String> get favorites => _favorites.value.favorites;

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
    // _asyncCallMsg.value = 'Fetching new characters...';
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
    // _asyncCallMsg.value = '';
  }

  Future<void> onPressCharacter(Character character) async {
    _selectedCharacter.value = character;
    _asyncCallMsg.value = 'Loading homeworld and species...';
    final homeworld =
        await _characterRepository.getHomeworldName(url: character.homeworld);
    final species =
        await _characterRepository.getSpeciesNames(urls: character.species);
    _selectedCharacter.value = selectedCharacter.copyWith(
      homeworld: homeworld,
      species: species,
    );
    _asyncCallMsg.value = '';
  }

  void onSearch(String value) {
    _searchText = value;
    pagingCharacters.refresh();
  }

  Future<void> addToFavorites(String fav) async {
    favorites.add(fav);
    await StorageUtils.writeContent(
        content: jsonEncode(this), name: 'favorites');
  }

  @override
  void onClose() {
    pagingCharacters.dispose();
    super.onClose();
  }
}
