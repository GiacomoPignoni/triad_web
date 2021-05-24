import 'package:triad_web/models/pair.dart';

class DiceModel {
  Pair position;
  int value;
  bool isFirstPlayer;
  bool removed = false;

  DiceModel(this.position, this.value, this.isFirstPlayer);
}