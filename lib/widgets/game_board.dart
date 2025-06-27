import 'package:flutter/material.dart';
import '../logic/tile_data.dart';
import '../constants/game_constants.dart';
import 'animated_tile.dart';

class GameBoard extends StatefulWidget {
  final List<TileData> tiles;
  final Animation<double> scaleAnimation;
  final Function(String) onSwipe;
  final bool gameOver;
  final bool isAnimating;

  const GameBoard({
    super.key,
    required this.tiles,
    required this.scaleAnimation,
    required this.onSwipe,
    required this.gameOver,
    required this.isAnimating,
  });

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  Offset? _startPosition;
  bool _directionSent = false;

  @override
  Widget build(BuildContext context) {
    double spacing = 8.0;
    double boardWidth = MediaQuery.of(context).size.width - 32; // margin
    double totalSpacing = spacing * (GameConstants.boardSize + 1);
    double cellSize = (boardWidth - totalSpacing) / GameConstants.boardSize;

    return Center(
      child: Container(
        margin: const EdgeInsets.all(16),
        width: boardWidth,
        height: boardWidth,
        decoration: BoxDecoration(
          color: GameConstants.boardColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanStart: (_) {
            _startPosition = null;
          },
          onPanUpdate: (details) {
            if (widget.gameOver || widget.isAnimating) return;

            if (_startPosition == null) {
              _startPosition = details.localPosition;
              return;
            }

            final delta = details.localPosition - _startPosition!;
            final dx = delta.dx;
            final dy = delta.dy;

            if (dx.abs() > 30 || dy.abs() > 30) {
              String? direction;
              if (dx.abs() > dy.abs()) {
                direction = dx > 0 ? 'right' : 'left';
              } else {
                direction = dy > 0 ? 'down' : 'up';
              }

              if (!_directionSent) {
                _directionSent = true;
                widget.onSwipe(direction);
              }
            }
          },
          onPanEnd: (_) {
            _startPosition = null;
            _directionSent = false;
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Stack(
              children: [
                // Background grid
                ...List.generate(GameConstants.boardSize, (row) {
                  return List.generate(GameConstants.boardSize, (col) {
                    double left = col * (cellSize + spacing);
                    double top = row * (cellSize + spacing);
                    return Positioned(
                      left: left,
                      top: top,
                      width: cellSize,
                      height: cellSize,
                      child: Container(
                        decoration: BoxDecoration(
                          color: GameConstants.emptyCellColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    );
                  });
                }).expand((e) => e),

                // Tiles
                ...widget.tiles.map(
                  (tile) => AnimatedTile(
                    tile: tile,
                    cellSize: cellSize,
                    spacing: spacing,
                    scaleAnimation: widget.scaleAnimation,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
