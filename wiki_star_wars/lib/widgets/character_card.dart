import 'package:flutter/material.dart';
import 'package:wiki_star_wars/models/character.dart';
import 'package:wiki_star_wars/widgets/favorite_button.dart';
import 'package:wiki_star_wars/widgets/profile_avatar.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  final VoidCallback? onPressed;
  final Color? bgColor;
  const CharacterCard(
      {Key? key, required this.character, this.onPressed, this.bgColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: bgColor ?? theme.primaryColor,
          borderRadius: BorderRadius.circular(
            10.0,
          ),
          boxShadow: [
            BoxShadow(
              spreadRadius: 2,
              color: theme.shadowColor.withOpacity(0.5),
              offset: const Offset(0, 2),
              blurRadius: 5,
            )
          ],
        ),
        child: Wrap(
          direction: Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          clipBehavior: Clip.antiAlias,
          runSpacing: 10.0,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [FavoriteButton(isSelected: false, onSelect: () {})],
            ),
            ProfileAvatar(
              name: character.name,
              bgColor: bgColor,
            ),
            Column(
              children: [
                _Text(label: 'Height', description: character.height),
                _Text(label: 'Mass', description: character.mass),
                _Text(label: 'Gender', description: character.gender),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _Text extends StatelessWidget {
  final String label;
  final String description;
  const _Text({Key? key, required this.label, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label + ': ',
          style: theme.textTheme.headline4
              ?.apply(color: theme.backgroundColor, fontWeightDelta: 7),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          description,
          style: theme.textTheme.headline4?.apply(
            color: theme.backgroundColor,
          ),
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}
