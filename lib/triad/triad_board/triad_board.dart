import 'package:flutter/material.dart';
import 'package:triad_web/models/dice_model.dart';
import 'package:triad_web/triad/triad_board/dice.dart';
import 'package:triad_web/triad/triad_board/tile.dart';
import 'package:triad_web/triad/triad_board/tile_states.dart';
import 'package:triad_web/utils/stream_data.dart';

class TriadBoard extends StatelessWidget {
  final int size;
  
  final StreamData<List<List<TileStates>>> board;

  final List<StreamData<DiceModel>> player1Dices;
  final List<StreamData<DiceModel>> player2Dices;

  final Function(int x, int y) onTilePressed;
  final Function(StreamData<DiceModel>) onDicePressed;

  TriadBoard({
    required this.board,
    required this.player1Dices,
    required this.player2Dices,
    required this.onTilePressed,
    required this.onDicePressed,
    this.size = 80
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.height * (size / 100),
      height: MediaQuery.of(context).size.height * (size / 100),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              StreamBuilder<List<List<TileStates>>>(
                stream: board.stream,
                initialData: board.value,
                builder: (context, snapshot) {
                  return Column(
                    children: List.generate(
                      snapshot.data!.length,
                      (y) => Row(
                        children: List.generate(
                          snapshot.data![y].length,
                          (x) => Tile(
                            size: constraints.maxWidth / 6,
                            state: snapshot.data![y][x],
                            x: x,
                            y: y,
                            onPressed: onTilePressed,
                          )
                        ),
                      )
                    ),
                  );
                }
              ),
              ...List.generate(
                player2Dices.length,
                (index) => Dice(
                  size: constraints.maxWidth / 6,
                  dice: player2Dices[index],
                  onPressed: onDicePressed,
                  board: board
                )
              ),
              ...List.generate(
                player1Dices.length,
                (index) => Dice(
                  size: constraints.maxWidth / 6,
                  dice: player1Dices[index],
                  onPressed: onDicePressed,
                  board: board
                )
              )
            ]
          );
        }
      ),
    );
  }
}