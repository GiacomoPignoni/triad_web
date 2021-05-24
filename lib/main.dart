import 'package:flutter/material.dart';
import 'package:triad_web/pages/home_page/home_page.dart';
import 'package:triad_web/pages/two_player_page/two_player_page.dart';
import 'package:triad_web/theme/theme.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      routes: {
        "two-player": (context) => TwoPlayerPage()
      },
      home: HomePage()
    );
  }
}