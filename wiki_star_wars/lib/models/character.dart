//todo: change to json_serializable/freezed
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
    };
    return json;
  }

  Character copyWith({String? homeworld}) => Character(
      name: name,
      height: height,
      gender: gender,
      mass: mass,
      hairColor: hairColor,
      skinColor: skinColor,
      eyeColor: eyeColor,
      birthYear: birthYear,
      homeworld: homeworld ?? this.homeworld);
}
