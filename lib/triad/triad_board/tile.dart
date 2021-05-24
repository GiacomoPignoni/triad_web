import 'package:flutter/material.dart';
import 'package:triad_web/triad/triad_board/tile_states.dart';

class Tile extends StatelessWidget {
  final double size;
  final TileStates state;
  final int x;
  final int y;

  final Function(int x, int y) onPressed;

  Tile({
    required this.size,
    required this.state,
    required this.x,
    required this.y,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (state == TileStates.canTap) ? () => onPressed(x, y) : null,
      child: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, anim) {
              return ScaleTransition(
                scale: anim,
                child: child,
              );
            },
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            child: (state != TileStates.none)
            ? Container(
              key: ValueKey<TileStates>(state),
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: _getColor(context)
              ),
            )
            : SizedBox.shrink()
          ),
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColorLight),
              color: Colors.transparent
            ),
          ),
        ],
      ),
    );
  }

  Color _getColor(BuildContext context) {
    switch(state) {
      case TileStates.canTap:
      case TileStates.selected:
        return Theme.of(context).shadowColor;
      case TileStates.triad:
        return Theme.of(context).highlightColor;
      case TileStates.none:
      default:
        return Colors.transparent;
    }
  }
}