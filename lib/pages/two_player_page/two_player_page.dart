import 'package:flutter/material.dart';
import 'package:triad_web/pages/two_player_page/two_player_page_controller.dart';
import 'package:triad_web/triad/triad_board/triad_board.dart';
import 'package:provider/provider.dart';

class TwoPlayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (ctx) => TwoPlayerPageController(ctx),
      dispose: (ctx, TwoPlayerPageController controller) => controller.dispose(),
      builder: (ctx, child) {
        return Consumer<TwoPlayerPageController>(
          builder: (ctx, controller, child) {
            return Scaffold(
              body: SafeArea(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Center(
                            child: StreamBuilder<String>(
                              stream: controller.text.stream,
                              initialData: controller.text.value,
                              builder: (ctx, snap) => Text(snap.data!),
                            )
                          ),
                        ),
                        TriadBoard(
                          size: 60,
                          board: controller.board,
                          player1Dices: controller.player1Dices,
                          player2Dices: controller.player2Dices,
                          onTilePressed: controller.onTilePressed,
                          onDicePressed: controller.onDicePressed,
                        ),
                        Expanded(child: Container())
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
