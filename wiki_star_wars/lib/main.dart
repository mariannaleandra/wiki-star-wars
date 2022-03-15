import 'package:flutter/material.dart';
import 'package:wiki_star_wars/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wiki Star Wars',
      theme: MainTheme.theme,
      home: const Scaffold(
        body: Center(
          child: Text('home'),
        ),
      ),
    );
  }
}
