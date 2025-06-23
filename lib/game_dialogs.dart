import 'package:flutter/material.dart';

class GameDialogs {
  static void showWinDialog(BuildContext context, VoidCallback onNewGame) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content: const Text(
            'You reached 2048! Keep playing to get a higher score.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Continue'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onNewGame();
              },
              child: const Text('New Game'),
            ),
          ],
        );
      },
    );
  }

  static void showGameOverDialog(
    BuildContext context,
    int score,
    VoidCallback onNewGame,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over!'),
          content: Text('Final Score: $score'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onNewGame();
              },
              child: const Text('Try Again'),
            ),
          ],
        );
      },
    );
  }
}
