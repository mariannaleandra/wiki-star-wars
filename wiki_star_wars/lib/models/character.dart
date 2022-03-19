//todo: change to freezed (toJson, fromJson, copyWith)
class Character {
  String name = '';
  String height = '';
  String gender = '';
  String mass = '';
  String hairColor = '';
  String skinColor = '';
  String eyeColor = '';
  String birthYear = '';
  String homeworld = '';
  List<String> species = [];

  Character.empty();

  Character({
    required this.name,
    required this.height,
    required this.gender,
    required this.mass,
    required this.hairColor,
    required this.skinColor,
    required this.eyeColor,
    required this.birthYear,
    required this.homeworld,
    required this.species,
  });

  Character.fromJson(final Map<String, dynamic> json) {
    json.forEach((final key, final value) {
      switch (key) {
        case 'name':
          name = value;
          break;
        case 'hair_color':
          hairColor = value;
          break;
        case 'height':
          height = value;
          break;
        case 'gender':
          gender = value;
          break;
        case 'mass':
          mass = value;
          break;
        case 'skin_color':
          skinColor = value;
          break;
        case 'eye_color':
          eyeColor = value;
          break;
        case 'birth_year':
          birthYear = value;
          break;
        case 'homeworld':
          homeworld = value;
          break;
        case 'species':
          species = (value as List).map((e) => e.toString()).toList();
          break;
        default:
          break;
      }
    });
  }

  Map<String, String> toJson() {
    var json = {
      'name': name,
      'height': height,
      'gender': gender,
      'mass': mass,
      'hair_color': hairColor,
      'skin_color': skinColor,
      'eye_color': eyeColor,
      'birth_year': birthYear,
      'homeworld': homeworld,
      'species': species.toString(),
    };
    return json;
  }

  Character copyWith({String? homeworld, List<String>? species}) => Character(
        name: name,
        height: height,
        gender: gender,
        mass: mass,
        hairColor: hairColor,
        skinColor: skinColor,
        eyeColor: eyeColor,
        birthYear: birthYear,
        homeworld: homeworld ?? this.homeworld,
        species: species ?? this.species,
      );
}
