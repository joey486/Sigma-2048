import 'package:flutter/material.dart';
import '../tile_data.dart';
import './game_constants.dart';
import './game_logic.dart';
import './move_logic.dart';
import './game_board.dart';
import './score_header.dart';
import './game_dialogs.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  List<List<int>> board = GameLogic.createEmptyBoard();
  List<TileData> tiles = [];
  int score = 0;
  bool gameOver = false;
  bool won = false;
  bool isAnimating = false;
  int tileIdCounter = 0;

  late AnimationController _moveAnimationController;
  late AnimationController _scaleAnimationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _moveAnimationController = AnimationController(
      duration: GameConstants.moveAnimationDuration,
      vsync: this,
    );
    _scaleAnimationController = AnimationController(
      duration: GameConstants.scaleAnimationDuration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _scaleAnimationController,
        curve: Curves.elasticOut,
      ),
    );
    initializeGame();
  }

  @override
  void dispose() {
    _moveAnimationController.dispose();
    _scaleAnimationController.dispose();
    super.dispose();
  }

  void initializeGame() {
    board = GameLogic.createEmptyBoard();
    tiles = [];
    score = 0;
    gameOver = false;
    won = false;
    isAnimating = false;
    tileIdCounter = 0;
    addRandomTile();
    addRandomTile();
    setState(() {});
  }

  void addRandomTile() {
    TileData? newTile = GameLogic.addRandomTile(board, tileIdCounter++);
    if (newTile != null) {
      tiles.add(newTile);
      _scaleAnimationController.forward().then((_) {
        _scaleAnimationController.reset();
        setState(() {
          for (var tile in tiles) {
            tile.isNew = false;
          }
        });
      });
    }
  }

  void checkGameStatus() {
    if (GameLogic.hasWinningTile(board) && !won) {
      won = true;
      GameDialogs.showWinDialog(context, initializeGame);
      return;
    }

    if (!GameLogic.canMove(board)) {
      gameOver = true;
      GameDialogs.showGameOverDialog(context, score, initializeGame);
    }
  }

  Future<void> performMove(Function moveFunction) async {
    if (isAnimating) return;

    List<List<int>> previousBoard = GameLogic.copyBoard(board);
    int scoreGained = moveFunction(board);

    if (!GameLogic.boardsEqual(previousBoard, board)) {
      setState(() {
        isAnimating = true;
        score += scoreGained;
        tiles = GameLogic.updateTilesFromBoard(board);
      });

      await _moveAnimationController.forward();
      _moveAnimationController.reset();

      setState(() {
        isAnimating = false;
      });

      addRandomTile();
      checkGameStatus();
    }
  }

  void handleSwipe(String direction) {
    switch (direction) {
      case 'left':
        performMove(MoveLogic.moveLeft);
        break;
      case 'right':
        performMove(MoveLogic.moveRight);
        break;
      case 'up':
        performMove(MoveLogic.moveUp);
        break;
      case 'down':
        performMove(MoveLogic.moveDown);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameConstants.backgroundColor,
      appBar: AppBar(
        title: const Text(
          '2048',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: GameConstants.appBarColor,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: initializeGame,
          ),
        ],
      ),
      body: Column(
        children: [
          ScoreHeader(score: score, onNewGame: initializeGame),
          Expanded(
            child: GameBoard(
              tiles: tiles,
              scaleAnimation: _scaleAnimation,
              onSwipe: handleSwipe,
              gameOver: gameOver,
              isAnimating: isAnimating,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Swipe to move tiles!',
              style: TextStyle(
                fontSize: 16,
                color: GameConstants.darkTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
