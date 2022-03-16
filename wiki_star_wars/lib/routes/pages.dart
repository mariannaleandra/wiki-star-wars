import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:wiki_star_wars/modules/Home/home_bindings.dart';
import 'package:wiki_star_wars/modules/Home/home_page.dart';
import 'package:wiki_star_wars/routes/routes.dart';

class AppPages {
  // map of routes that will be used by GetX
  static final pages = [
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomeBindings(),
    ),
  ];
}
