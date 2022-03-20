import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wiki_star_wars/constants/storage_constants.dart';
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

  final int _pageSize = 10;

  String _searchText = '';

  final _asyncCallMsg = ''.obs;
  String get loadingMsg => _asyncCallMsg.value;
  bool get isLoading => _asyncCallMsg.value.isNotEmpty;

  final _favorites = Favorites.empty().obs;
  List<String> get favorites => _favorites.value.favorites;
  bool get favReqFailed => _favoriteRepository.lastFailed;

  final _onlyFavorites = false.obs;
  bool get onlyFavorites => _onlyFavorites.value;

  @override
  void onInit() {
    super.onInit();
    pagingCharacters
        .addPageRequestListener((pageKey) => _fetchPageCharacters(pageKey));
    _readDataFavorites().then((_) => _retryFavFailed());
  }

  Future<void> _fetchPageCharacters(int pageKey) async {
    // _asyncCallMsg.value = 'Fetching new characters...';
    bool firstLoad = pageKey == 1 && _searchText.isEmpty && !onlyFavorites;
    try {
      final hasConnection = await InternetUtils.checkConnection();

      if (hasConnection) {
        var newPage = await _characterRepository.listCharacters(
          page: pageKey,
          search: _searchText,
        );

        final newCharacters = onlyFavorites
            ? newPage.results
                .where((element) => favorites.contains(element.url))
                .toList()
            : newPage.results;

        if (newCharacters.length < _pageSize) {
          pagingCharacters.appendLastPage(newCharacters);
        } else {
          pagingCharacters.appendPage(newCharacters, pageKey + 1);
        }

        if (firstLoad) {
          //save file data on first reload
          _writeData(
            StorageConstants.CHARACTERS_STORAGE,
            jsonEncode(newCharacters),
          );
        }
      } else if (firstLoad) {
        pagingCharacters
          ..itemList = await _readDataCharacters()
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

  Future<void> toggleFavorite(Character character,
      {Function(String value)? addFavorite}) async {
    final favUrl = character.url;
    if (favorites.contains(favUrl)) {
      _removeFavorites(favUrl);
    } else {
      await _addToFavorites(
        favUrl,
        addFavorite: addFavorite,
      );
    }
    await _writeData(
      StorageConstants.FAVORITES_STORAGE,
      jsonEncode(_favorites.value),
    );
  }

  Future<void> _addToFavorites(String favUrl,
      {Function(String value)? addFavorite}) async {
    _favorites.value.favorites = [...favorites, favUrl];
    _favorites.refresh();
    final msg = await _favorite(favUrl);
    addFavorite?.call(msg);
  }

  void _removeFavorites(String favUrl) {
    var favs = _favorites.value.favorites;
    favs.remove(favUrl);
    _favorites.value.favorites = [...favs];
    _favorites.refresh();
  }

  void _addFailed(String url) {
    _favorites.value.failed = [..._favorites.value.failed, url];
    _favorites.refresh();
  }

  void _removeFailed(String url) {
    var faileds = _favorites.value.failed;
    faileds.remove(url);
    _favorites.value.failed = [...faileds];
    _favorites.refresh();
  }

  Future<String> _favorite(String favUrl) async {
    final favSplit = favUrl.split('/');

    final favId = favSplit[favSplit.length - 2];
    final response = await _favoriteRepository.favorite(id: favId);

    if (_favoriteRepository.lastFailed) {
      _addFailed(favUrl);
    }

    return response;
  }

  Future<void> _retryFavFailed() async {
    final failed = _favorites.value.failed;
    _favorites.value.failed = [];
    _favorites.refresh();
    for (int i = 0; i < failed.length; ++i) {
      await _favorite(failed[i]);
    }
    await _writeData(
      StorageConstants.FAVORITES_STORAGE,
      jsonEncode(_favorites.value),
    );
  }

  Future<void> _readDataFavorites() async {
    try {
      final content = await StorageUtils.readcontent(
          storage: StorageConstants.FAVORITES_STORAGE);
      _favorites.value = Favorites.fromJson(jsonDecode(content));
    } on Exception catch (e) {
      debugPrint('[ERROR] :: error trying to read data :: $e');
    }
  }

  Future<List<Character>> _readDataCharacters() async {
    var list = <Character>[];
    try {
      final content = await StorageUtils.readcontent(
          storage: StorageConstants.CHARACTERS_STORAGE);
      Iterable l = jsonDecode(content);
      list = List<Character>.from(l.map((model) => Character.fromJson(model)));
    } on Exception catch (e) {
      debugPrint('[ERROR] :: error trying to read data :: $e');
    }
    return list;
  }

  Future<void> _writeData(String storage, String content) async {
    try {
      await StorageUtils.writeContent(content: content, storage: storage);
    } on Exception catch (e) {
      debugPrint('[ERROR] :: error trying to write data :: $e');
    }
  }

  void filterFavorites() {
    _onlyFavorites.value = !onlyFavorites;
    pagingCharacters.refresh();
  }

  @override
  void onClose() {
    pagingCharacters.dispose();
    super.onClose();
  }
}
