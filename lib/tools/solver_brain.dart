class SolverBrain {
  List<List<int>> board = [
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
  ];

  void assignValue({int index, int val = 0}) {
    int col = index % 9;
    int row = index ~/ 9;

    isValid(val, row, col) ? board[row][col] = val : board[row][col] = 0;
  }

  void printBoard() {
    print(board);
  }

  void resetBoard() {
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        board[i][j] = 0;
      }
    }
  }

  bool isValid(int n, int r, int c) {
    bool badRow = false;
    bool badCol = false;
    bool badCell = false;
    int cell = 0; // keypad cell designator for selected location (1-9)

    // determine if row is safe
    for (int i = 0; i < 9; i++) {
      if (board[r][i] == n) {
        badRow = true;
      }
    }

    // determine if the column is safe
    for (int i = 0; i < 9; i++) {
      if (board[i][c] == n) {
        badCol = true;
      }
    }

    // determine which cell the number is in
    if (c < 3) {
      if (r < 3) {
        cell = 1;
      } else if (r < 6) {
        cell = 4;
      } else {
        cell = 7;
      }
    } else if (c < 6) {
      if (r < 3) {
        cell = 2;
      } else if (r < 6) {
        cell = 5;
      } else {
        cell = 8;
      }
    } else if (c < 9) {
      if (r < 3) {
        cell = 3;
      } else if (r < 6) {
        cell = 6;
      } else {
        cell = 9;
      }
    }

    // determine if the cell is safe by checking the values in the cell [r][c] is in
    if (cell == 1) {
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (board[i][j] == n) {
            badCell = true;
          }
        }
      }
    } else if (cell == 2) {
      for (int i = 0; i < 3; i++) {
        for (int j = 3; j < 6; j++) {
          if (board[i][j] == n) {
            badCell = true;
          }
        }
      }
    } else if (cell == 3) {
      for (int i = 0; i < 3; i++) {
        for (int j = 6; j < 9; j++) {
          if (board[i][j] == n) {
            badCell = true;
          }
        }
      }
    } else if (cell == 4) {
      for (int i = 3; i < 6; i++) {
        for (int j = 0; j < 3; j++) {
          if (board[i][j] == n) {
            badCell = true;
          }
        }
      }
    } else if (cell == 5) {
      for (int i = 3; i < 6; i++) {
        for (int j = 3; j < 6; j++) {
          if (board[i][j] == n) {
            badCell = true;
          }
        }
      }
    } else if (cell == 6) {
      for (int i = 3; i < 6; i++) {
        for (int j = 6; j < 9; j++) {
          if (board[i][j] == n) {
            badCell = true;
          }
        }
      }
    } else if (cell == 7) {
      for (int i = 6; i < 9; i++) {
        for (int j = 0; j < 3; j++) {
          if (board[i][j] == n) {
            badCell = true;
          }
        }
      }
    } else if (cell == 8) {
      for (int i = 6; i < 9; i++) {
        for (int j = 3; j < 6; j++) {
          if (board[i][j] == n) {
            badCell = true;
          }
        }
      }
    } else {
      for (int i = 6; i < 9; i++) {
        for (int j = 6; j < 9; j++) {
          if (board[i][j] == n) {
            badCell = true;
          }
        }
      }
    }

    if (badRow || badCol || badCell) {
      return false;
    }
    return true;
  }

  bool isFull() {
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (board[i][j] == 0) {
          //  0 represents an unassigned location
          return false;
        }
      }
    }
    return true;
  }

  bool solve() {
    // if the board is full, we are done
    if (isFull()) {
      return true;
    }

    int row, col;
    bool found = false;

    // find the next unassigned location
    for (row = 0; row < 9; row++) {
      for (col = 0; col < 9; col++) {
        if (board[row][col] == 0) {
          found = true;
          break;
        }
      }
      if (found) {
        break;
      }
    }

    // for every digit, see if it is valid and leads to a solution
    for (int i = 1; i <= 9; i++) {
      if (isValid(i, row, col)) {
        board[row][col] = i; // assign number to empty spot if valid
        if (solve() == true) {
          // if this leads to a solution, return true
          return true;
        } else {
          board[row][col] = 0; //  else, reset the location to 0
        }
      }
    }
    return false; //  return false if solution not found, this causes the current location to be reset to 0 and a different number to be selected (backtracking)
  }
}
