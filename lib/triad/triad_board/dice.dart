import 'package:flutter/material.dart';
import 'package:triad_web/models/dice_model.dart';
import 'package:triad_web/triad/triad_board/pulse_container.dart';
import 'package:triad_web/triad/triad_board/tile_states.dart';
import 'package:triad_web/utils/stream_data.dart';

class Dice extends StatelessWidget {
  final double size;
  final StreamData<DiceModel> dice;
  final StreamData<List<List<TileStates>>> board;

  final Function(StreamData<DiceModel> dice) onPressed;

  Dice({
    required this.size,
    required this.dice,
    required this.onPressed,
    required this.board
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DiceModel>(
      stream: dice.stream,
      initialData: dice.value,
      builder: (context, diceSnap) {
        final color = (diceSnap.data!.isFirstPlayer) ? Theme.of(context).primaryColor : Theme.of(context).accentColor;
        final numberColor = (diceSnap.data!.isFirstPlayer) ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColorDark;

        return AnimatedPositioned(
          left: (diceSnap.data!.removed) ? diceSnap.data!.isFirstPlayer ? 1000 : -1000 : diceSnap.data!.position.x * size,
          top: diceSnap.data!.position.y * size,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          child: GestureDetector(
            onTap: () => onPressed(dice),
            child: Container(
              width: size,
              height: size,
              padding: const EdgeInsets.all(5),
              child: StreamBuilder<List<List<TileStates>>>(
                stream: board.stream,
                initialData: board.value,
                builder: (context, boardSnap) {
                  return PulseContainer(
                    color: color,
                    borderRadius: BorderRadius.circular(10),
                    pulse: _pulse(boardSnap.data!, diceSnap.data!),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        diceSnap.data!.value,
                        (index) => VerticalDivider(
                          color: numberColor, thickness: 3, indent: 8, endIndent: 8, width: 8,
                        )
                      ),
                    )
                  );
                }
              ),
            ),
          ),
        );
      }
    );
  }

  bool _pulse(List<List<TileStates>> board, DiceModel dice) {
    final val = board[dice.position.y][dice.position.x];
    return val == TileStates.triad || val == TileStates.selected;
  }
}