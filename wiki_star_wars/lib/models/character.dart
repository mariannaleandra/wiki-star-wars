class Character {
  String url = '';
  String name = '';

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
        default:
          break;
      }
    });
  }
}
