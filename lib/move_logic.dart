import './game_constants.dart';

class MoveLogic {
  static int moveLeft(List<List<int>> board) {
    int scoreGained = 0;

    for (int i = 0; i < GameConstants.boardSize; i++) {
      List<int> row = board[i].where((val) => val != 0).toList();

      for (int j = 0; j < row.length - 1; j++) {
        if (row[j] == row[j + 1]) {
          row[j] *= 2;
          scoreGained += row[j];
          row.removeAt(j + 1);
        }
      }

      while (row.length < GameConstants.boardSize) {
        row.add(0);
      }

      board[i] = row;
    }

    return scoreGained;
  }

  static int moveRight(List<List<int>> board) {
    int scoreGained = 0;

    for (int i = 0; i < GameConstants.boardSize; i++) {
      List<int> row = board[i].where((val) => val != 0).toList();

      for (int j = row.length - 1; j > 0; j--) {
        if (row[j] == row[j - 1]) {
          row[j] *= 2;
          scoreGained += row[j];
          row.removeAt(j - 1);
          j--;
        }
      }

      while (row.length < GameConstants.boardSize) {
        row.insert(0, 0);
      }

      board[i] = row;
    }

    return scoreGained;
  }

  static int moveUp(List<List<int>> board) {
    int scoreGained = 0;

    for (int j = 0; j < GameConstants.boardSize; j++) {
      List<int> column = [];
      for (int i = 0; i < GameConstants.boardSize; i++) {
        if (board[i][j] != 0) {
          column.add(board[i][j]);
        }
      }

      for (int i = 0; i < column.length - 1; i++) {
        if (column[i] == column[i + 1]) {
          column[i] *= 2;
          scoreGained += column[i];
          column.removeAt(i + 1);
        }
      }

      while (column.length < GameConstants.boardSize) {
        column.add(0);
      }

      for (int i = 0; i < GameConstants.boardSize; i++) {
        board[i][j] = column[i];
      }
    }

    return scoreGained;
  }

  static int moveDown(List<List<int>> board) {
    int scoreGained = 0;

    for (int j = 0; j < GameConstants.boardSize; j++) {
      List<int> column = [];
      for (int i = 0; i < GameConstants.boardSize; i++) {
        if (board[i][j] != 0) {
          column.add(board[i][j]);
        }
      }

      for (int i = column.length - 1; i > 0; i--) {
        if (column[i] == column[i - 1]) {
          column[i] *= 2;
          scoreGained += column[i];
          column.removeAt(i - 1);
          i--;
        }
      }

      while (column.length < GameConstants.boardSize) {
        column.insert(0, 0);
      }

      for (int i = 0; i < GameConstants.boardSize; i++) {
        board[i][j] = column[i];
      }
    }

    return scoreGained;
  }
}
