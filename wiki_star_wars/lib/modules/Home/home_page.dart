import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiki_star_wars/modules/Home/home_controller.dart';
import 'package:wiki_star_wars/widgets/characters_lane.dart';
import 'package:wiki_star_wars/widgets/loading.dart';
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
                child: CharactersLane(
                  onCharacterPress: (character) =>
                      controller.onPressCharacter(character),
                  pagingController: controller.pagingCharacters,
                ),
              ),
            ],
          ),
        ));
  }
}
