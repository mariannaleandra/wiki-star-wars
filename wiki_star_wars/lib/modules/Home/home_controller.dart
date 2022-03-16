import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:wiki_star_wars/repositories/character_repository.dart';

class HomeController extends GetxController {
  final CharacterRepository _characterRepository;
  HomeController(this._characterRepository);
}
