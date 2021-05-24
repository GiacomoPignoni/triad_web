import 'dart:math';
import 'package:triad_web/models/dice_model.dart';
import 'package:triad_web/models/move_result.dart';
import 'package:triad_web/models/pair.dart';
import 'package:triad_web/triad/triad_board/tile_states.dart';
import 'package:triad_web/utils/ref_value.dart';

class TriadLogic {

  static List<List<TileStates>> get emptyBoard {
    final List<List<TileStates>> board = [];
    for(int i = 0; i < 6; i++) {
      board.add([]);
      for(int j = 0; j < 6; j++) {
        board[i].add(TileStates.none);
      }
    }
    return board;
  }

  static List<int> generateDices({bool reversed = false}) {
    final List<int> list = [];
    final rnd = Random();
    for(int i = 0; i < 6; i++) {
      list.add(1 + rnd.nextInt(4 - 1));
    }
    if(reversed) {
      list.sort((a, b) => b - a);
    } else {
      list.sort();
    }
    return list;
  }

  static bool canMove(List<List<int>> board, DiceModel dice, Pair to) {
    final temp = whereCanMove(board, dice);
    if(board[to.y][to.x] != 0 || temp[to.y][to.x] == TileStates.none) {
      return false;
    }
    return true;
  }

  static List<List<TileStates>> whereCanMove(List<List<int>> board, DiceModel diceToMove) {
    final x = diceToMove.position.x;
    final y = diceToMove.position.y;
    final temp = emptyBoard;
    final vals = [1, 2, 3];
    vals.remove(diceToMove.value);

    for(int i = 0; i < vals.length; i++) {
      final val = vals[i];

      if(y + val < 6 && board[y + val][x] == 0) {
        bool valid = true;
        for(int j = 1; j < val; j++) {
          if(board[y + j][x] != 0) {
            valid = false;
          }
        }
        if(valid) {
          temp[y + val][x] = TileStates.canTap;       
        }
      }
      if(y - val >= 0 && board[y - val][x] == 0) {
        bool valid = true;
        for(int j = 1; j < val; j++) {
          if(board[y - j][x] != 0) {
            valid = false;
          }
        }
        if(valid) {
          temp[y - val][x] = TileStates.canTap;
        }
      }

      if(x + val < 6 && board[y][x + val] == 0) {
        bool valid = true;
        for(int j = 1; j < val; j++) {
          if(board[y][x + j] != 0) {
            valid = false;
          }
        }
        if(valid) {
          temp[y][x + val] = TileStates.canTap;  
        }          
      }
      if(x - val >= 0 && board[y][x - val] == 0) {
        bool valid = true;
        for(int j = 1; j < val; j++) {
          if(board[y][x - j] != 0) {
            valid = false;
          }
        }
        if(valid) {
          temp[y][x - val] = TileStates.canTap;
        }
      }

      if(y - val >= 0 && x - val >= 0 && board[y - val][x - val] == 0) {
        bool valid = true;
        for(int j = 1; j < val; j++) {
          if(board[y - j][x - j] != 0) {
            valid = false;
          }
        }
        if(valid) {
          temp[y - val][x - val] = TileStates.canTap;
        }        
      }
      if(y - val >= 0 && x + val < 6 && board[y - val][x + val] == 0) {
        bool valid = true;
        for(int j = 1; j < val; j++) {
          if(board[y - j][x + j] != 0) {
            valid = false;
          }
        }
        if(valid) {
          temp[y - val][x + val] = TileStates.canTap;
        }
      }
      if(y + val < 6 && x - val >= 0 && board[y + val][x - val] == 0) {
        bool valid = true;
        for(int j = 1; j < val; j++) {
          if(board[y + j][x - j] != 0) {
            valid = false;
          }
        }
        if(valid) { 
          temp[y + val][x - val] = TileStates.canTap;
        }      
      }
      if(y + val < 6 && x + val < 6 && board[y + val][x + val] == 0) {
        bool valid = true;
        for(int j = 1; j < val; j++) {
          if(board[y + j][x + j] != 0) {
            valid = false;
          }
        }
        if(valid) {
          temp[y + val][x + val] = TileStates.canTap;
        }
      }     
    }
    return temp;
  }

  static MoveResult move(List<List<int>> board, DiceModel dice, Pair to) {
    if(canMove(board, dice, to) == false) {
      return MoveResult(done: false);
    }

    int dis = max((to.x - dice.position.x).abs(), (to.y - dice.position.y).abs());
    board[to.y][to.x] = (board[dice.position.y][dice.position.x] < 0) ? -dis : dis;
    board[dice.position.y][dice.position.x] = 0;

    RefValue<bool> foundTriad = RefValue(false);
    final triadsBoard = findTriads(board, to, foundTriad);

    dice.position = to;
    dice.value = dis;

    return MoveResult(
      done: true,
      newDice: dice, 
      triadsBoard: triadsBoard,
      hasTriad: foundTriad.value
    );
  }

  static List<List<TileStates>> findTriads(List<List<int>> board, Pair position, RefValue found) {
    final triads = emptyBoard;
    final int x = position.x;
    final int y = position.y;

    // Centric search
    if(x > 0 && x < 5 && y > 0 && y < 5) {
      if(isTriad([board[y - 1][x], board[y][x], board[y + 1][x]])) {
        triads[y - 1][x] = TileStates.triad;
        triads[y][x] = TileStates.triad;
        triads[y + 1][x] = TileStates.triad;
        found.value = true;
      }

      if(isTriad([board[y][x - 1], board[y][x], board[y][x + 1]])) {
        triads[y][x - 1] = TileStates.triad;
        triads[y][x] = TileStates.triad;
        triads[y][x + 1] = TileStates.triad;
        found.value = true;
      }

      if(isTriad([board[y - 1][x + 1], board[y][x], board[y + 1][x - 1]])) {
        triads[y - 1][x + 1] = TileStates.triad;
        triads[y][x] = TileStates.triad;
        triads[y + 1][x - 1] = TileStates.triad;
        found.value = true;
      }

      if(isTriad([board[y - 1][x - 1], board[y][x], board[y + 1][x + 1]])) {
        triads[y - 1][x - 1] = TileStates.triad;
        triads[y][x] = TileStates.triad;
        triads[y + 1][x + 1] = TileStates.triad;
        found.value = true;
      }
    } else if((x == 0 && y > 0 && y < 5) || (x == 5 && y < 5 && y > 0)) {
      if(isTriad([board[y - 1][x], board[y][x], board[y + 1][x]])) {
        triads[y - 1][x] = TileStates.triad;
        triads[y][x] = TileStates.triad;
        triads[y + 1][x] = TileStates.triad;
      }
    } else if((y == 0 && x > 0 && x < 5) || (y == 5 && x > 0 && x < 5)) {
      if(isTriad([board[y][x - 1], board[y][x], board[y][x + 1]])) {
        triads[y][x - 1] = TileStates.triad;
        triads[y][x] = TileStates.triad;
        triads[y][x + 1] = TileStates.triad;
        found.value = true;
      }
    }

    // Leaf search
    if(x < 4) {
      if(isTriad([board[y][x], board[y][x + 1], board[y][x + 2]])) {
        triads[y][x] = TileStates.triad;
        triads[y][x + 1] = TileStates.triad;
        triads[y][x + 2] = TileStates.triad;
        found.value = true;
      }
    }

    if(x > 1) {
      if(isTriad([board[y][x], board[y][x - 1], board[y][x - 2]])) {
        triads[y][x] = TileStates.triad;
        triads[y][x - 1] = TileStates.triad;
        triads[y][x - 2] = TileStates.triad;
        found.value = true;
      }
    }

    if(y < 4) {
      if(isTriad([board[y][x], board[y + 1][x], board[y + 2][x]])) {
        triads[y][x] = TileStates.triad;
        triads[y + 1][x] = TileStates.triad;
        triads[y + 2][x] = TileStates.triad;
        found.value = true;
      }
    }

    if(y > 1) {
      if(isTriad([board[y][x], board[y - 1][x], board[y - 2][x]])) {
        triads[y][x] = TileStates.triad;
        triads[y - 1][x] = TileStates.triad;
        triads[y - 2][x] = TileStates.triad;
        found.value = true;
      }
    }

    if(x < 4 && y > 1) {
      if(isTriad([board[y][x], board[y - 1][x + 1], board[y - 2][x + 2]])) {
        triads[y][x] = TileStates.triad;
        triads[y - 1][x + 1] = TileStates.triad;
        triads[y - 2][x + 2] = TileStates.triad;
        found.value = true;
      }
    }

    if(x > 1 && y > 1) {
      if(isTriad([board[y][x], board[y - 1][x - 1], board[y - 2][x - 2]])) {
        triads[y][x] = TileStates.triad;
        triads[y - 1][x - 1] = TileStates.triad;
        triads[y - 2][x - 2] = TileStates.triad;
        found.value = true;
      }
    }

    if(x < 4 && y < 4) {
      if(isTriad([board[y][x], board[y + 1][x + 1], board[y + 2][x + 2]])) {
        triads[y][x] = TileStates.triad;
        triads[y + 1][x + 1] = TileStates.triad;
        triads[y + 2][x + 2] = TileStates.triad;
        found.value = true;
      }
    }

    if(x > 1 && y < 4) {
      if(isTriad([board[y][x], board[y + 1][x - 1], board[y + 2][x - 2]])) {
        triads[y][x] = TileStates.triad;
        triads[y + 1][x - 1] = TileStates.triad;
        triads[y + 2][x - 2] = TileStates.triad;
        found.value = true;
      }
    }

    return triads;
  }

  static bool isTriad(List<int> tris) {
    if(tris.contains(0)) {
      return false;
    }

    if(tris.where((x) => x > 0).length == 3 || tris.where((x) => x < 0).length == 3) {
      return false;
    }

    final first = tris[0].abs();
    if(tris.every((x) => x.abs() == first)) {
      return true;
    }

    final vals = [1, 2, 3];
    for(int i = 0; i < tris.length; i++) {
      final index = vals.indexOf(tris[i].abs());
      if(index > -1) {
        vals.removeAt(index);
      }
    }
    return vals.length == 0;
  }
}
