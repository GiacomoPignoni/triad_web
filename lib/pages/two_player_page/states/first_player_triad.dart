import 'package:flutter/material.dart';
import 'package:triad_web/models/dice_model.dart';
import 'package:triad_web/dialogs/game_over_dialog/game_over_dialog.dart';
import 'package:triad_web/pages/two_player_page/states/second_player_play.dart';
import 'package:triad_web/pages/two_player_page/states/two_player_state.dart';
import 'package:triad_web/triad/triad_board/tile_states.dart';
import 'package:triad_web/triad/triad_logic.dart';
import 'package:triad_web/utils/stream_data.dart';

class FirstPlayerTriad extends TwoPlayerState {
  
  FirstPlayerTriad(
    BuildContext context,
    StreamData<List<List<TileStates>>> board,
    List<StreamData<DiceModel>> player1Dices,
    List<StreamData<DiceModel>> player2Dices,
    StreamData<String> player1Text
  ) : super(context, board, player1Dices, player2Dices, player1Text);

  @override
  void start() {
    text.add("Player 1 made a TRIAD");
  }

  @override
  TwoPlayerState? onDicePressed(StreamData<DiceModel> dice) {
    if(dice.value.isFirstPlayer == false) return null;

    if(board.value[dice.value.position.y][dice.value.position.x] != TileStates.triad) {
      return null;
    }

    final newDice = dice.value;
    newDice.removed = true;
    dice.add(newDice);
    board.add(TriadLogic.emptyBoard);

    if(player1Dices.where((x) => x.value.removed == true).length >= 3) {
      GameOverDialog.show(context, "Player 1 Win!"); 
    }

    return SecondPlayerPlay(context, board, player1Dices, player2Dices, text);
  }

  @override
  TwoPlayerState? onTilePressed(int x, int y) {
    return null;
  }
}