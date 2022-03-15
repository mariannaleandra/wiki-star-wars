import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainTheme {
  static final ThemeData theme = ThemeData(
    primaryColor: Colors.primaryDefault,
    primaryColorDark: Colors.primaryDark,
    primaryColorLight: Colors.primaryLight,
    scaffoldBackgroundColor: Colors.light,
    iconTheme: const IconThemeData(
      color: Colors.darkYellow,
      size: 25.0,
    ),
    textTheme: FontTheme.theme,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.primaryDefault,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Colors.primaryDefault,
    ),
  );
}

class FontTheme {
  static final TextTheme theme = TextTheme(
    headline1: GoogleFonts.sourceSansPro(
      color: Colors.dark,
      fontSize: 24,
      fontWeight: FontWeight.normal,
    ),
    headline2: GoogleFonts.sourceSansPro(
      color: Colors.dark,
      fontSize: 20,
      fontWeight: FontWeight.normal,
    ),
    headline3: GoogleFonts.sourceSansPro(
      color: Colors.dark,
      fontSize: 18,
      fontWeight: FontWeight.normal,
    ),
    headline4: GoogleFonts.sourceSansPro(
      fontSize: 16,
      color: Colors.dark,
      fontWeight: FontWeight.normal,
    ),
    headline5: GoogleFonts.sourceSansPro(
      fontSize: 14,
      color: Colors.dark,
      fontWeight: FontWeight.normal,
    ),
    headline6: GoogleFonts.sourceSansPro(
      fontSize: 12,
      color: Colors.dark,
      fontWeight: FontWeight.normal,
    ),
  );
}

class Colors {
  static const primaryDefault = Color(0xFF25484f);
  static const primaryDark = Color(0xFF1f2731);
  static const primaryLight = Color(0xFF34796a);

  static const dark = Color(0xFF010102);
  static const light = Color(0xFFecf1c1);

  static const darkRed = Color(0xFF381010);
  static const darkYellow = Color(0xFFad7d37);
}
