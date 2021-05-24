
import 'package:triad_web/models/dice_model.dart';
import 'package:triad_web/triad/triad_board/tile_states.dart';

class MoveResult {
  final bool done;
  final DiceModel? newDice;
  final List<List<TileStates>>? triadsBoard;
  final bool hasTriad;

  MoveResult({
    required this.done,
    this.newDice,
    this.triadsBoard,
    this.hasTriad = false
  });
}