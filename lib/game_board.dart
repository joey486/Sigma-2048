import 'package:flutter/material.dart';
import './tile_data.dart';
import './game_constants.dart';
import './animated_tile.dart';

class GameBoard extends StatelessWidget {
  final List<TileData> tiles;
  final Animation<double> scaleAnimation;
  final Function(String) onSwipe;
  final bool gameOver;
  final bool isAnimating;

  const GameBoard({
    Key? key,
    required this.tiles,
    required this.scaleAnimation,
    required this.onSwipe,
    required this.gameOver,
    required this.isAnimating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onPanEnd: (details) {
          if (gameOver || isAnimating) return;

          final velocity = details.velocity.pixelsPerSecond;
          final dx = velocity.dx;
          final dy = velocity.dy;

          if (dx.abs() > dy.abs()) {
            if (dx > 0) {
              onSwipe('right');
            } else {
              onSwipe('left');
            }
          } else {
            if (dy > 0) {
              onSwipe('down');
            } else {
              onSwipe('up');
            }
          }
        },
        child: Container(
          margin: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width - 32,
          height: MediaQuery.of(context).size.width - 32,
          decoration: BoxDecoration(
            color: GameConstants.boardColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Stack(
              children: [
                // Background grid
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: GameConstants.boardSize,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: GameConstants.boardSize * GameConstants.boardSize,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: GameConstants.emptyCellColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  },
                ),
                // Animated tiles
                ...tiles.map((tile) {
                  // Calculate cell size based on container dimensions
                  double containerWidth =
                      MediaQuery.of(context).size.width -
                      48; // margin + padding
                  double cellSize =
                      (containerWidth - 32) /
                      GameConstants.boardSize; // account for spacing
                  double spacing = 8.0;

                  return AnimatedTile(
                    tile: tile,
                    cellSize: cellSize,
                    spacing: spacing,
                    scaleAnimation: scaleAnimation,
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
