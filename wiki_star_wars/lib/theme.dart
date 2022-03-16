import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainTheme {
  static final ThemeData theme = ThemeData(
    primaryColor: _ColorsTheme.primaryDefault,
    primaryColorDark: _ColorsTheme.primaryDark,
    primaryColorLight: _ColorsTheme.primaryLight,
    shadowColor: _ColorsTheme.primaryDark,
    errorColor: _ColorsTheme.danger,
    canvasColor: _ColorsTheme.darkRed,
    backgroundColor: _ColorsTheme.light,
    cardColor: _ColorsTheme.primaryDefault,
    iconTheme: const IconThemeData(
      color: _ColorsTheme.darkYellow,
      size: 25.0,
    ),
    textTheme: _FontTheme.theme,
    appBarTheme: _AppBarTheme.theme,
    bottomAppBarTheme: const BottomAppBarTheme(
      color: _ColorsTheme.primaryDefault,
    ),
  );
}

class _FontTheme {
  static final TextTheme theme = TextTheme(
    headline1: GoogleFonts.sourceSansPro(
      color: _ColorsTheme.dark,
      fontSize: 24,
      fontWeight: FontWeight.normal,
    ),
    headline2: GoogleFonts.sourceSansPro(
      color: _ColorsTheme.dark,
      fontSize: 20,
      fontWeight: FontWeight.normal,
    ),
    headline3: GoogleFonts.sourceSansPro(
      color: _ColorsTheme.dark,
      fontSize: 18,
      fontWeight: FontWeight.normal,
    ),
    headline4: GoogleFonts.sourceSansPro(
      fontSize: 16,
      color: _ColorsTheme.dark,
      fontWeight: FontWeight.normal,
    ),
    headline5: GoogleFonts.sourceSansPro(
      fontSize: 14,
      color: _ColorsTheme.dark,
      fontWeight: FontWeight.normal,
    ),
    headline6: GoogleFonts.sourceSansPro(
      fontSize: 12,
      color: _ColorsTheme.dark,
      fontWeight: FontWeight.normal,
    ),
  );
}

class _ColorsTheme {
  static const primaryDefault = Color(0xFF25484f);
  static const primaryDark = Color(0xFF1f2731);
  static const primaryLight = Color(0xFF34796a);

  static const dark = Color(0xFF010102);
  static const light = Color.fromARGB(255, 255, 255, 255);

  static const darkRed = Color(0xFF381010);
  static const darkYellow = Color(0xFFad7d37);
  static const danger = Color(0xFFB71C1C);
}

class _AppBarTheme {
  static final theme = AppBarTheme(
      backgroundColor: _ColorsTheme.primaryDefault,
      titleTextStyle:
          _FontTheme.theme.headline2?.apply(color: _ColorsTheme.light));
}
