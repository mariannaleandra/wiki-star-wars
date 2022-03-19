import 'package:flutter/material.dart';
import 'package:wiki_star_wars/models/character.dart';
import 'package:wiki_star_wars/widgets/field.dart';
import 'package:wiki_star_wars/widgets/profile_avatar.dart';

class CharacterView extends StatelessWidget {
  final Character character;
  final bool loadingData;
  final String loadingMsg;
  final Color? bgColor;
  const CharacterView(
      {Key? key,
      required this.character,
      required this.loadingData,
      this.loadingMsg = '',
      this.bgColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.8,
      padding: const EdgeInsets.all(
        10.0,
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onVerticalDragDown: (_) => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: theme.backgroundColor,
                  size: theme.iconTheme.size,
                ),
              ),
            ),
            ProfileAvatar(
              name: character.name,
              bgColor: bgColor ?? theme.primaryColor,
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Field(
                    text: character.homeworld,
                    label: 'homeworld',
                    icon: Icons.home,
                    loadingData: loadingData,
                    loadingMsg: loadingMsg,
                    color: bgColor,
                  ),
                  Field(
                    text: character.species.isEmpty
                        ? 'No especies found :('
                        : character.species.join(' - '),
                    label: 'species',
                    icon: Icons.local_florist,
                    loadingData: loadingData,
                    loadingMsg: loadingMsg,
                    color: bgColor,
                  ),
                  ..._buildFields(
                    exclude: [
                      'name',
                      'species',
                      'homeworld',
                      'url',
                    ],
                  ),
                ],
              ),
            ),
          ]),
    );
  }

  List<Widget> _buildFields({required List<String> exclude}) {
    final json = character.toJson();
    var list = <Widget>[];
    json.forEach((key, value) {
      if (!exclude.contains(key)) {
        list.add(
          Field(
            label: key,
            text: value,
            icon: Icons.face,
            color: bgColor,
          ),
        );
      }
    });
    return list;
  }
}
