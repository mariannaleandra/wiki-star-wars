import 'package:flutter/material.dart';
import 'package:wiki_star_wars/models/character.dart';

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
    return GestureDetector(
      onTap: onPressed,
      child: Container(
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
          alignment: WrapAlignment.center,
          spacing: 10,
          runAlignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          direction: Axis.vertical,
          children: [
            CircleAvatar(
              backgroundColor: bgColor,
              backgroundImage: const AssetImage('assets/images/helmet.png'),
              radius: 40,
            ),
            Text(
              character.name,
              style: theme.textTheme.headline2?.apply(
                color: theme.backgroundColor,
                fontWeightDelta: 7,
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
