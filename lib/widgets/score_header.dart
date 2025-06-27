import 'package:flutter/material.dart';
import '../constants/game_constants.dart';

class ScoreHeader extends StatelessWidget {
  final int score;
  final VoidCallback onNewGame;

  const ScoreHeader({super.key, required this.score, required this.onNewGame});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: GameConstants.appBarColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Score: $score',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: onNewGame,
            style: ElevatedButton.styleFrom(
              backgroundColor: GameConstants.appBarColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: const Text(
              'New Game',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
