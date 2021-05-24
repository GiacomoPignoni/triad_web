import 'package:flutter/material.dart';
import 'package:triad_web/models/dice_model.dart';
import 'package:triad_web/triad/triad_board/tile_states.dart';
import 'package:triad_web/utils/stream_data.dart';

class TwoPlayerState {
  final BuildContext context;

  final StreamData<List<List<TileStates>>> board;
  final List<StreamData<DiceModel>> player1Dices;
  final List<StreamData<DiceModel>> player2Dices;

  final StreamData<String> text;

  StreamData<DiceModel>? selectedDice;

  TwoPlayerState(
    this.context, this.board, this.player1Dices, this.player2Dices,
    this.text
  );
  
  TwoPlayerState? onDicePressed(StreamData<DiceModel> dice) {
    throw UnimplementedError();
  }

  TwoPlayerState? onTilePressed(int x, int y) {
    throw UnimplementedError();
  }

  void start() {
    throw UnimplementedError();
  }

  List<List<int>> generateMatrixBoard() {
    final List<List<int>> matrixBoard = [];

    for(int row = 0; row < 6; row++) {
      matrixBoard.add([]);
      for(int col = 0; col < 6; col++) {
        matrixBoard[row].add(0);
      }
    }

    for(final dice in player1Dices) {
      if(dice.value.removed) continue;

      matrixBoard[dice.value.position.y][dice.value.position.x] = dice.value.value;
    }
    for(final dice in player2Dices) {
      if(dice.value.removed) continue;
      
      matrixBoard[dice.value.position.y][dice.value.position.x] = -dice.value.value;
    }

    return matrixBoard;
  }
}