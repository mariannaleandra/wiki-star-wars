class Favorites {
  List<String> favorites = [];
  List<String> failed = [];

  Favorites.empty();

  // Favorites({required this.favorites, required this.failed});

  Favorites.fromJson(final Map<String, dynamic> json) {
    json.forEach((final key, final value) {
      switch (key) {
        case 'favorites':
          favorites = (value as List).map((e) => e.toString()).toList();
          break;
        case 'failed':
          failed = (value as List).map((e) => e.toString()).toList();
          break;
        default:
          break;
      }
    });
  }

  Map<String, dynamic> toJson() => {
        'favorites': favorites,
        'failed': failed,
      };
}
