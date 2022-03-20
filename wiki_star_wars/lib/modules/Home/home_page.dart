import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiki_star_wars/models/character.dart';
import 'package:wiki_star_wars/modules/Home/home_controller.dart';
import 'package:wiki_star_wars/widgets/character_view.dart';
import 'package:wiki_star_wars/widgets/characters_lane.dart';
import 'package:wiki_star_wars/widgets/favorite_button.dart';
import 'package:wiki_star_wars/widgets/search_input.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Wiki Star Wars',
          style: theme.appBarTheme.titleTextStyle,
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            SearchInput(
              onSearch: controller.onSearch,
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Obx(
                () => CharactersLane(
                  onCharacterPress: (character, color) {
                    controller.onPressCharacter(character);
                    _openCharacter(theme, controller.selectedCharacter, color);
                  },
                  pagingController: controller.pagingCharacters,
                  favorites: controller.favorites,
                  onToggleFavorite: (character) => controller.toggleFavorite(
                    character,
                    addFavorite: (value) => _showSnackbar(value, theme),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openCharacter(ThemeData theme, Character character, Color bgColor) {
    Get.bottomSheet(
      Obx(
        () => CharacterView(
          character: controller.selectedCharacter,
          loadingData: controller.isLoading,
          loadingMsg: controller.loadingMsg,
          bgColor: bgColor,
          isFavorite: controller.favorites.contains(character.url),
          onToggleFavorite: () => controller.toggleFavorite(
            character,
            addFavorite: (value) => _showSnackbar(
              value,
              theme,
            ),
          ),
        ),
      ),
      enableDrag: true,
      isScrollControlled: true,
      shape: const OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      backgroundColor: bgColor,
    );
  }

  void _showSnackbar(String value, ThemeData theme) {
    Get.snackbar(
      '',
      '',
      snackPosition: SnackPosition.TOP,
      backgroundColor: theme.snackBarTheme.backgroundColor,
      duration: const Duration(seconds: 3),
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(10.0),
      borderRadius: 10.0,
      titleText: const SizedBox.shrink(),
      messageText: Text(
        value,
        style: theme.snackBarTheme.contentTextStyle,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      icon: Icon(
        Icons.star,
        size: theme.iconTheme.size,
        color: theme.iconTheme.color,
      ),
      shouldIconPulse: true,
    );
  }
}
