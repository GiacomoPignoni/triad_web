class Pair {
  final int x;
  final int y;

  Pair(this.x, this.y);

  String toString() {
    return "$x $y";
  }

  String toStringWith({
    int addX = 0,
    int addY = 0
  }) {
    return "${x + addX} ${y + addY}";
  }

  Pair copyWith({
    int addX = 0,
    int addY = 0
  }) {
    return Pair(x + addX, y + addY);
  }
}