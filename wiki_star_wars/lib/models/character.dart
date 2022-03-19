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
}
