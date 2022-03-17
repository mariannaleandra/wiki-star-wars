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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: bgColor,
              backgroundImage: const AssetImage('assets/images/helmet.png'),
              radius: 40,
            ),
            const SizedBox(height: 10),
            Text(
              character.name,
              style: theme.textTheme.headline2?.apply(
                color: theme.backgroundColor,
                fontWeightDelta: 7,
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            _Text(label: 'Height', description: character.height),
            _Text(label: 'Mass', description: character.mass),
            _Text(label: 'Gender', description: character.gender),
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
