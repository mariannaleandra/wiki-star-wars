class Character {
  String url = '';
  String name = '';
  String height = '';
  String gender = '';
  String mass = '';

  Character.empty();

  Character.fromJson(final Map<String, dynamic> json) {
    json.forEach((final key, final value) {
      switch (key) {
        case 'name':
          name = value;
          break;
        case 'url':
          url = value;
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
        default:
          break;
      }
    });
  }

  Map<String, String> toJson() {
    var json = {
      'name': name,
      'height': height,
      'url': url,
      'gender': gender,
      'mass': mass
    };
    return json;
  }
}
