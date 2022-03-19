import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiki_star_wars/models/character.dart';
import 'package:wiki_star_wars/modules/Home/home_controller.dart';
import 'package:wiki_star_wars/widgets/character_view.dart';
import 'package:wiki_star_wars/widgets/characters_lane.dart';
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
                    _openCharacter(
                        context, controller.selectedCharacter, theme, color);
                  },
                  pagingController: controller.pagingCharacters,
                  favorites: controller.favorites,
                  onToggleFavorite: controller.toggleFavorite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openCharacter(BuildContext context, Character character,
      ThemeData theme, Color bgColor) {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      isScrollControlled: true,
      shape: const OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      backgroundColor: bgColor,
      builder: (context) => Obx(
        () => CharacterView(
          character: controller.selectedCharacter,
          loadingData: controller.isLoading,
          loadingMsg: controller.loadingMsg,
          bgColor: bgColor,
        ),
      ),
    );
  }
}
