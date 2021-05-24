import 'package:flutter/material.dart';
import 'package:triad_web/models/dice_model.dart';
import 'package:triad_web/models/pair.dart';
import 'package:triad_web/pages/two_player_page/states/first_player_triad.dart';
import 'package:triad_web/pages/two_player_page/states/second_player_play.dart';
import 'package:triad_web/pages/two_player_page/states/two_player_state.dart';
import 'package:triad_web/triad/triad_board/tile_states.dart';
import 'package:triad_web/triad/triad_logic.dart';
import 'package:triad_web/utils/stream_data.dart';

class FirstPlayerPlay extends TwoPlayerState {
  
  FirstPlayerPlay(
    BuildContext context,
    StreamData<List<List<TileStates>>> board,
    List<StreamData<DiceModel>> player1Dices,
    List<StreamData<DiceModel>> player2Dices,
    StreamData<String> player1Text
  ) : super(context, board, player1Dices, player2Dices, player1Text);

  @override
  void start() {
    text.add("Player 1 move");
  }

  @override
  TwoPlayerState? onDicePressed(StreamData<DiceModel> dice) {
    if(dice.value.isFirstPlayer == false) return null;

    if(selectedDice == dice) {
      selectedDice = null;
      board.add(TriadLogic.emptyBoard);
    } else {
      final temp = TriadLogic.whereCanMove(generateMatrixBoard(), dice.value);
      temp[dice.value.position.y][dice.value.position.x] = TileStates.selected;
      selectedDice = dice;
      board.add(temp);
    }
  }

  @override
  TwoPlayerState? onTilePressed(int x, int y) {
    if(selectedDice == null || board.value[y][x] == TileStates.none) {
      return null;
    }

    final moveResult = TriadLogic.move(generateMatrixBoard(), selectedDice!.value, Pair(x, y));
    if(moveResult.done) {
      selectedDice!.add(moveResult.newDice!);
      board.add(moveResult.triadsBoard!);
      selectedDice = null;
      if(moveResult.hasTriad) {
        return FirstPlayerTriad(context, board, player1Dices, player2Dices, text);
      } else {
        return SecondPlayerPlay(context, board, player1Dices, player2Dices, text);
      }
    }

    return null;
  }
  
}