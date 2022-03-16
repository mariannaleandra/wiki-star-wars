class Page<T> {
  int count = 0;
  String? next;
  String? previous;
  List<T> results = [];

  Page();

  Page.empty();

  Page.fromJson(final Map<String, dynamic> json,
      final T Function(dynamic json) fromJson) {
    json.forEach((final key, final value) {
      switch (key) {
        case 'count':
          count = value;
          break;
        case 'next':
          next = value;
          break;
        case 'previous':
          previous = value;
          break;
        case 'results':
          (value as List).removeWhere((final e) => e == null);
          results = value.map(fromJson).toList();
          break;
        default:
          break;
      }
    });
  }
}
