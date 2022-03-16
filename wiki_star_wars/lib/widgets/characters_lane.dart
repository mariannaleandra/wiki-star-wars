import 'package:flutter/material.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wiki_star_wars/models/character.dart';
import 'package:wiki_star_wars/widgets/character_card.dart';
import 'package:wiki_star_wars/widgets/loading.dart';

class CharactersLane extends StatelessWidget {
  final void Function(Character character) onCharacterPress;
  final PagingController<int, Character> pagingController;

  const CharactersLane(
      {final Key? key,
      required this.onCharacterPress,
      required this.pagingController})
      : super(key: key);

  @override
  Widget build(final BuildContext context) {
    var theme = Theme.of(context);
    return PagedListView<int, Character>(
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
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: CharacterCard(
              character: character,
              onPressed: () => onCharacterPress(character),
              bgColor:
                  index % 2 == 0 ? theme.primaryColor : theme.primaryColorDark,
            ),
          );
        },
        noMoreItemsIndicatorBuilder: (final context) => Center(
          child: Text(
            'all done :)',
            style: theme.textTheme.headline2,
          ),
        ),
      ),
    );
  }
}
