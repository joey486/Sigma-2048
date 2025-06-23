import 'dart:math';
import './tile_data.dart';
import './game_constants.dart';

class GameLogic {
  static List<List<int>> createEmptyBoard() {
    return List.generate(
      GameConstants.boardSize,
      (_) => List.filled(GameConstants.boardSize, 0),
    );
  }

  static List<List<int>> copyBoard(List<List<int>> original) {
    return original.map((row) => List<int>.from(row)).toList();
  }

  static bool boardsEqual(List<List<int>> board1, List<List<int>> board2) {
    for (int i = 0; i < GameConstants.boardSize; i++) {
      for (int j = 0; j < GameConstants.boardSize; j++) {
        if (board1[i][j] != board2[i][j]) return false;
      }
    }
    return true;
  }

  static List<List<int>> getEmptyCells(List<List<int>> board) {
    List<List<int>> emptyCells = [];
    for (int i = 0; i < GameConstants.boardSize; i++) {
      for (int j = 0; j < GameConstants.boardSize; j++) {
        if (board[i][j] == 0) {
          emptyCells.add([i, j]);
        }
      }
    }
    return emptyCells;
  }

  static TileData? addRandomTile(List<List<int>> board, int tileIdCounter) {
    List<List<int>> emptyCells = getEmptyCells(board);

    if (emptyCells.isNotEmpty) {
      Random random = Random();
      List<int> randomCell = emptyCells[random.nextInt(emptyCells.length)];
      int value = random.nextDouble() < 0.9 ? 2 : 4;
      board[randomCell[0]][randomCell[1]] = value;

      return TileData(
        value: value,
        row: randomCell[0],
        col: randomCell[1],
        id: 'tile_${tileIdCounter}',
        isNew: true,
      );
    }
    return null;
  }

  static bool canMove(List<List<int>> board) {
    // Check for empty cells
    for (int i = 0; i < GameConstants.boardSize; i++) {
      for (int j = 0; j < GameConstants.boardSize; j++) {
        if (board[i][j] == 0) return true;
      }
    }

    // Check for possible merges
    for (int i = 0; i < GameConstants.boardSize; i++) {
      for (int j = 0; j < GameConstants.boardSize; j++) {
        if (j < GameConstants.boardSize - 1 && board[i][j] == board[i][j + 1])
          return true;
        if (i < GameConstants.boardSize - 1 && board[i][j] == board[i + 1][j])
          return true;
      }
    }

    return false;
  }

  static bool hasWinningTile(List<List<int>> board) {
    for (int i = 0; i < GameConstants.boardSize; i++) {
      for (int j = 0; j < GameConstants.boardSize; j++) {
        if (board[i][j] == GameConstants.winningTile) {
          return true;
        }
      }
    }
    return false;
  }

  static List<TileData> updateTilesFromBoard(List<List<int>> board) {
    List<TileData> tiles = [];
    for (int i = 0; i < GameConstants.boardSize; i++) {
      for (int j = 0; j < GameConstants.boardSize; j++) {
        if (board[i][j] != 0) {
          tiles.add(
            TileData(
              value: board[i][j],
              row: i,
              col: j,
              id: 'tile_${i}_${j}_${board[i][j]}',
            ),
          );
        }
      }
    }
    return tiles;
  }
}
