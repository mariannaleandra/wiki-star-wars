import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:wiki_star_wars/routes/pages.dart';
import 'package:wiki_star_wars/routes/routes.dart';
import 'package:wiki_star_wars/theme.dart';

void main() {
  runApp(const WikiStarWarsApp());
}

class WikiStarWarsApp extends StatelessWidget {
  const WikiStarWarsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Wiki Star Wars',
      theme: MainTheme.theme,
      initialRoute: Routes.home,
      getPages: AppPages.pages,
    );
  }
}
