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
    var screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: screenSize.width * 0.7,
        height: 100,
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
        child: Column(
          children: [
            Text(
              character.name,
              style: theme.textTheme.headline3?.apply(
                color: theme.backgroundColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
