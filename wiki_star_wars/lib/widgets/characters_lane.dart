import 'package:flutter/material.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wiki_star_wars/models/character.dart';
import 'package:wiki_star_wars/widgets/character_card.dart';
import 'package:wiki_star_wars/widgets/loading.dart';

class CharactersLane extends StatelessWidget {
  final void Function(Character character, Color color) onCharacterPress;
  final PagingController<int, Character> pagingController;
  final List<String> favorites;
  final Function(Character character) onToggleFavorite;

  const CharactersLane({
    final Key? key,
    required this.onCharacterPress,
    required this.pagingController,
    required this.favorites,
    required this.onToggleFavorite,
  }) : super(key: key);

  //random background colors for card
  Color _bgColor(int index, ThemeData theme) {
    if (index % 4 == 0) {
      return theme.primaryColorLight;
    } else if (index % 3 == 0) {
      return theme.primaryColorDark;
    } else if (index % 2 == 0) {
      return theme.primaryColor;
    }
    return theme.primaryColor;
  }

  @override
  Widget build(final BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return PagedGridView<int, Character>(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: size.width / size.height / 0.8,
      ),
      pagingController: pagingController,
      builderDelegate: PagedChildBuilderDelegate<Character>(
        firstPageProgressIndicatorBuilder: (final context) =>
            const LoadingWidget(),
        newPageProgressIndicatorBuilder: (final context) =>
            const LoadingWidget(),
        noItemsFoundIndicatorBuilder: (final context) => Center(
          child: Text(
            'no characters found :(',
            style: theme.textTheme.headline2,
          ),
        ),
        itemBuilder: (final context, final character, final index) {
          final bgColor = _bgColor(index + 1, theme);
          return CharacterCard(
            character: character,
            onPressed: () => onCharacterPress(character, bgColor),
            bgColor: bgColor,
            isFavorite: favorites.contains(character.url),
            onToggleFavorite: () => onToggleFavorite(character),
          );
        },
      ),
    );
  }
}
