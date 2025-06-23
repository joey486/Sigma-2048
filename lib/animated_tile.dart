import 'package:flutter/material.dart';
import './tile_data.dart';
import './game_constants.dart';

class AnimatedTile extends StatelessWidget {
  final TileData tile;
  final double cellSize;
  final double spacing;
  final Animation<double> scaleAnimation;

  const AnimatedTile({
    Key? key,
    required this.tile,
    required this.cellSize,
    required this.spacing,
    required this.scaleAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double left = tile.col * (cellSize + spacing);
    double top = tile.row * (cellSize + spacing);

    return AnimatedPositioned(
      key: Key(tile.id),
      duration: GameConstants.moveAnimationDuration,
      curve: Curves.easeInOut,
      left: left,
      top: top,
      width: cellSize,
      height: cellSize,
      child: AnimatedBuilder(
        animation: scaleAnimation,
        builder: (context, child) {
          double scale = tile.isNew ? scaleAnimation.value : 1.0;
          return Transform.scale(
            scale: scale,
            child: Container(
              decoration: BoxDecoration(
                color:
                    GameConstants.tileColors[tile.value] ??
                    const Color(0xFF3C3A32),
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  tile.value.toString(),
                  style: TextStyle(
                    fontSize: tile.value < 100
                        ? cellSize * 0.4
                        : tile.value < 1000
                        ? cellSize * 0.35
                        : cellSize * 0.3,
                    fontWeight: FontWeight.bold,
                    color: tile.value <= 4
                        ? GameConstants.darkTextColor
                        : Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
