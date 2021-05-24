import 'package:flutter/material.dart';
import 'package:triad_web/models/dice_model.dart';
import 'package:triad_web/models/pair.dart';
import 'package:triad_web/pages/two_player_page/states/first_player_play.dart';
import 'package:triad_web/pages/two_player_page/states/two_player_state.dart';
import 'package:triad_web/triad/triad_board/tile_states.dart';
import 'package:triad_web/triad/triad_logic.dart';
import 'package:triad_web/utils/stream_data.dart';

class TwoPlayerPageController {
  final BuildContext context;

  late List<StreamData<DiceModel>> player1Dices;
  late List<StreamData<DiceModel>> player2Dices;
  late StreamData<List<List<TileStates>>> board;

  final StreamData<String> text = StreamData(initialValue: "");

  late TwoPlayerState currentState;

  TwoPlayerPageController(this.context) {
    player1Dices = [];
    player2Dices = [];
    board = StreamData(initialValue: [], broadcast: true);
    final generatedPlayerDices = TriadLogic.generateDices();
    final generatedEnemyDices = TriadLogic.generateDices(reversed: true);

    for(int i = 0; i < 6; i++) {
      player1Dices.add(StreamData(initialValue: DiceModel(Pair(i, 5), generatedPlayerDices[i], true)));
      player2Dices.add(StreamData(initialValue: DiceModel(Pair(i, 0), generatedEnemyDices[i], false)));

      board.value.add([]);
      for(int j = 0; j < 6; j++) {
        board.value[i].add(TileStates.none);
      }
    }

    currentState = FirstPlayerPlay(context, board, player1Dices, player2Dices, text);
    currentState.start();
  }

  void onDicePressed(StreamData<DiceModel> dice) {
    final newState = currentState.onDicePressed(dice);
    if(newState != null) {
      currentState = newState;
      currentState.start();
    }
  }

  void onTilePressed(int x, int y) {
    final newState = currentState.onTilePressed(x, y);
    if(newState != null) {
      currentState = newState;
      currentState.start();
    }
  }

  void dispose() {
    board.close();
    text.close();
    for(int i = 0; i < player1Dices.length; i++) {
      player1Dices[i].close();
      player2Dices[i].close();
    }
  }
}