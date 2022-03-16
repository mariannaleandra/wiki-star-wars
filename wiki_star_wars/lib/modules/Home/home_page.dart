import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:wiki_star_wars/modules/Home/home_controller.dart';
import 'package:wiki_star_wars/widgets/characters_lane.dart';
import 'package:wiki_star_wars/widgets/loading.dart';

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
              Expanded(
                child: Obx(
                  () => controller.inAsyncCall
                      ? const LoadingWidget()
                      : CharactersLane(
                          onCharacterPress: (character) =>
                              controller.onPressCharacter(character),
                          pagingController: controller.pagingCharacters,
                        ),
                ),
              ),
            ],
          ),
        ));
  }
}
