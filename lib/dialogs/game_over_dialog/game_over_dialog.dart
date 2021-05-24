import 'package:flutter/material.dart';
import 'package:triad_web/widgets/button.dart';

class GameOverDialog extends StatelessWidget {
  final String winner;

  GameOverDialog({
    required this.winner
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Game Over!",
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            ),
            Divider(),
            Text(
              winner,
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
            Divider(),
            Button(
              text: "Exit",
              onPressed: () => Navigator.of(context).popUntil((route) => route.settings.name == "home"),
            )
          ]
        ),
      ),
    );
  }
  
  static void show(BuildContext context, String winner) {
    showGeneralDialog(
      context: context,
      barrierLabel: "game-over-dialog",
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (context, anim1, anim2, dialog) {
        final curvedAnim = CurvedAnimation(parent: anim1, curve: Curves.easeInOut);

        return ScaleTransition(
          scale: curvedAnim,
          child: dialog,
        );
      },
      pageBuilder: (context, anim1, anim2) => GameOverDialog(winner: winner)
    );
  }
}