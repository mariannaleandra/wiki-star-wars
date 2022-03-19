import 'package:get/get.dart';
import 'package:wiki_star_wars/modules/Home/home_controller.dart';
import 'package:wiki_star_wars/repositories/character_repository.dart';
import 'package:wiki_star_wars/repositories/favorites_repository.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
        () => HomeController(CharacterRepository(), FavoriteRepository()));
  }
}
