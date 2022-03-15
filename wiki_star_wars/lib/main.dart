import 'package:flutter/material.dart';
import 'package:wiki_star_wars/theme.dart';

void main() {
  runApp(const WikiStarWarsApp());
}

class WikiStarWarsApp extends StatelessWidget {
  const WikiStarWarsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MaterialApp(
      title: 'Wiki Star Wars',
      theme: MainTheme.theme,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'wiki star wars',
            style: theme.appBarTheme.titleTextStyle,
          ),
          backgroundColor: theme.appBarTheme.backgroundColor,
        ),
        body: const Center(
          child: Text('home'),
        ),
      ),
    );
  }
}
