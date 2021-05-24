import 'package:flutter/material.dart';

const Color LIGHT = Colors.white;
const Color DARK = Color(0xFF313131);

final theme = ThemeData(
  scaffoldBackgroundColor: Color(0xFF262626),
  primaryColor: Color(0xFF4B83D5),
  accentColor: LIGHT,
  shadowColor: Colors.grey.withAlpha(100),
  highlightColor: Colors.yellow,
  primaryColorLight: LIGHT,
  primaryColorDark: DARK,
  dividerColor: Colors.transparent,
  iconTheme: IconThemeData(
    color: LIGHT,
    size: 30
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: DARK,
      fontSize: 18
    ),
    bodyText2: TextStyle(
      color: LIGHT,
      fontSize: 18
    ),
    headline1: TextStyle(
      color: LIGHT,
      fontSize: 50
    ),
    headline2: TextStyle(
      color: LIGHT,
      fontSize: 30
    ),
    headline4: TextStyle(
      color: LIGHT,
      fontSize: 22
    ),
    button: TextStyle(
      color: LIGHT,
      fontSize: 22,
      fontWeight: FontWeight.w300
    ),
  )
);