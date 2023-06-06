public class Grid {
  int[][] gameBoard;
  Tile[][] tiles;
  float size = 80;
  int GameState = 0;
  int movementSignal = 0;
  boolean lost = false;
  
  public Grid() {
    gameBoard = new int[4][4];
    tiles = new Tile[4][4];
    
    for (int i = 0; i < tiles.length; i++) {
      for (int j = 0; j < tiles[i].length; j++) { 
        tiles[i][j] = new Tile((400+size*j) - (size*2), (300+size*i) - (size*2), size);
      }
    }
    spawnTiles();
  }
  
  public void update() {
    switch (GameState) {
      // check for loss
      case 0:
        checkForWinLossConditions();
      break;
      // add in tile
      case 1:
        addTile();
      break;
      // move and update Gameboard
      case 2: 
        updateGameBoard();
      break;
      // lose
      case 3:
        gameOver();
      break;
    }
    drawTiles();
  }
  
  public void spawnTiles() {
    int x = round(random(3));
    int y = round(random(3));
    int x1 = round(random(3));
    int y1 = round(random(3));
    while (x == x1) {
      x1 = round(random(3));
    }
    while (y == y1) {
      y1 = round(random(3));
    }
    
    gameBoard[x][y] = 2;
    gameBoard[x1][y1] = 2;
  }
  
  public void checkForWinLossConditions() {
    lost = true;
    for (int i = 0; i < gameBoard.length - 1; i++) {
      for (int j = 0; j < gameBoard[i].length - 1; j++) {
        if (gameBoard[i][j] == gameBoard[i + 1][j]) {
          lost = false;
          break;
        }
        if (gameBoard[i][j] == gameBoard[i][j + 1]) {
          lost = false; 
          break;
        }
        if (gameBoard[i][j] == 0 || gameBoard[i + 1][j] == 0) {
          lost = false;
          break;
        }
        if (gameBoard[i][j] == 0 || gameBoard[i][j + 1] == 0) {
          lost = false; 
          break;
        }
      }
    }
    if (lost) GameState = 3;
    else GameState = 1;
  }

  public void addTile() {
    ArrayList<Integer> validXIndicies = new ArrayList<Integer>();
    ArrayList<Integer> validYIndicies = new ArrayList<Integer>();
    
    for (int i = 0; i < gameBoard.length; i++) {
      for (int j = 0; j < gameBoard[i].length; j++) {
        if (gameBoard[i][j] == 0) {
          validXIndicies.add(j);
          validYIndicies.add(i);
        }
      }
    }
    int arrSize = validXIndicies.size() - 1;
    int choice = round(random(arrSize));
    if (validXIndicies.size() != 0) gameBoard[validYIndicies.get(choice)][validXIndicies.get(choice)] = 2;
    GameState = 2;
  }
  
  public void setMovementSignal(int movementSignal) { this.movementSignal = movementSignal; }

  public void updateGameBoard() {
    switch (movementSignal) {
      // no movement
      case 0: 
        return;
      // left
      case 1:
        left();
      break;
      // right
      case 2: 
        right();
      break;
      // up
      case 3: 
        up();
      break;
      // down
      case 4:
        down();
      break;
    }
  }
  
  private void left() {
    // movement pass (left to right)
    int[][] prevGameBoard = new int[4][4];
    for (int i = 0; i < gameBoard.length; i++) {
      for (int j = 0; j < gameBoard[i].length; j++) {
        prevGameBoard[i][j] = gameBoard[i][j];
      }
    } 
    for (int i = 0; i < gameBoard.length; i++) {
      for (int j = 0; j < gameBoard[i].length; j++) {
        if (gameBoard[i][j] != 0 && j > 0) {
          int occupiedIndex = peek(i, j, 1);
          if (occupiedIndex != -1 && gameBoard[i][occupiedIndex] == gameBoard[i][j]) {
            gameBoard[i][occupiedIndex]*=2;
            gameBoard[i][j] = 0;
          }
          else gameBoard[i][occupiedIndex + 1] = gameBoard[i][j];
          if (occupiedIndex + 1 != j) gameBoard[i][j] = 0;
        }
        delay(10);
      }
    }
    GameState = 2;
    for (int i = 0; i <gameBoard.length; i++) {
      for (int j = 0; j < gameBoard[i].length; j++) {
        if (gameBoard[i][j] != prevGameBoard[i][j]) {
          GameState = 0;
          break;
        }
      }
    } 
  }
  
  private void right() {
    // movement pass (right to left)
    int[][] prevGameBoard = new int[4][4];
    for (int i = 0; i < gameBoard.length; i++) {
      for (int j = 0; j < gameBoard[i].length; j++) {
        prevGameBoard[i][j] = gameBoard[i][j];
      }
    } 
    for (int i = 0; i < gameBoard.length; i++) {
      for (int j = gameBoard[i].length - 1; j >= 0; j--) {
        if (gameBoard[i][j] != 0 && j < gameBoard[i].length - 1) {
          int occupiedIndex = peek(i, j, 2);
          if (occupiedIndex != gameBoard[i].length && gameBoard[i][occupiedIndex] == gameBoard[i][j]) {
            gameBoard[i][occupiedIndex]*=2;
            gameBoard[i][j] = 0;
          }
          else gameBoard[i][occupiedIndex - 1] = gameBoard[i][j];
          if (occupiedIndex - 1 != j) gameBoard[i][j] = 0;
        }
        delay(10);
      }
    }
    GameState = 2;
    for (int i = 0; i < gameBoard.length; i++) {
      for (int j = 0; j < gameBoard[i].length; j++) {
        if (gameBoard[i][j] != prevGameBoard[i][j]) {
          GameState = 0;
          break;
        }
      }
    } 
  }
  
  private void up() {
     // movement pass (top to bottom)
    int[][] prevGameBoard = new int[4][4];
    for (int i = 0; i < gameBoard.length; i++) {
      for (int j = 0; j < gameBoard[i].length; j++) {
        prevGameBoard[i][j] = gameBoard[i][j];
      }
    } 
    for (int i = 0; i < gameBoard.length; i++) {
      for (int j = 0; j < gameBoard[i].length; j++) {
        if (gameBoard[i][j] != 0 && i > 0) {
          int occupiedIndex = peek(i, j, 3);
          if (occupiedIndex != -1 && gameBoard[occupiedIndex][j] == gameBoard[i][j]) {
            gameBoard[occupiedIndex][j]*=2;
            gameBoard[i][j] = 0;
          }
          else gameBoard[occupiedIndex + 1][j] = gameBoard[i][j];
          if (occupiedIndex + 1 != i) gameBoard[i][j] = 0;
        }
        delay(10);
      }
    }
    GameState = 2;
    for (int i = 0; i < gameBoard.length; i++) {
      for (int j = 0; j < gameBoard[i].length; j++) {
        if (gameBoard[i][j] != prevGameBoard[i][j]) {
          GameState = 0;
          break;
        }
      }
    } 
  }
  
  private void down() {
    // movement pass (bottom to top)
    int[][] prevGameBoard = new int[4][4];
    for (int i = 0; i < gameBoard.length; i++) {
      for (int j = 0; j < gameBoard[i].length; j++) {
        prevGameBoard[i][j] = gameBoard[i][j];
      }
    } 
    for (int i = gameBoard.length - 1; i >= 0; i--) {
      for (int j = 0; j < gameBoard[i].length; j++) {
        if (gameBoard[i][j] != 0 && i < gameBoard[i].length - 1) {
          int occupiedIndex = peek(i, j, 4);
          if (occupiedIndex != gameBoard.length && gameBoard[occupiedIndex][j] == gameBoard[i][j]) {
            gameBoard[occupiedIndex][j]*=2;
            gameBoard[i][j] = 0;
          }
          else gameBoard[occupiedIndex - 1][j] = gameBoard[i][j];
          if (occupiedIndex - 1 != i) gameBoard[i][j] = 0;
        }
        delay(10);
      }
    }
    GameState = 2;
    for (int i = 0; i < gameBoard.length; i++) {
      for (int j = 0; j < gameBoard[i].length; j++) {
        if (gameBoard[i][j] != prevGameBoard[i][j]) {
          GameState = 0;
          break;
        }
      }
    } 
  }
  
  public int peek(int rowIndex, int columnIndex, int direction) {
    switch (direction) {
      // left
      case 1: 
        for (int j = columnIndex - 1; j >= 0; j--) {
          if (gameBoard[rowIndex][j] != 0) 
            return j;
        }
      return -1;
      // right
      case 2: 
        for (int j = columnIndex + 1; j < gameBoard[rowIndex].length; j++) {
          if (gameBoard[rowIndex][j] != 0) 
            return j;
        }
      return gameBoard[rowIndex].length;
      // up
      case 3: 
        for (int i = rowIndex - 1; i >= 0; i--) {
          if (gameBoard[i][columnIndex] != 0) 
            return i;
        }
      return -1;
      // down
      case 4: 
        for (int i = rowIndex + 1; i < gameBoard.length; i++) {
          if (gameBoard[i][columnIndex] != 0) 
            return i;
        }
      return gameBoard.length;
    }
    return 0;
  }
  
  public void gameOver() {
    textSize(150);
    fill(255);
    textAlign(CENTER, CENTER);
    text("You Lost", 400, 300);
  }
  
  public void drawTiles() {
    if (lost) return;
    
    rectMode(CENTER);
    float xCenter = 400-size/2;
    float yCenter = 300-size/2;
    //rect(xCenter, yCenter, 4*size, 4*size);
    
    // horizontal gridLines
    stroke(25, 25, 200);
    line(xCenter - 2 * size, yCenter - size, xCenter + 2 * size, yCenter - size);
    line(xCenter - 2 * size, yCenter, xCenter + 2 * size, yCenter);
    line(xCenter - 2 * size, yCenter + size, xCenter + 2 * size, yCenter + size);
    // vertical gridlines
    line(xCenter - size, yCenter - 2 * size, xCenter - size, yCenter + 2 * size);
    line(xCenter, yCenter - 2 * size, xCenter, yCenter + 2 * size);
    line(xCenter + size, yCenter - 2 * size, xCenter + size, yCenter + 2 * size);
    
    for (int i = 0; i < tiles.length; i++) {
      for (int j = 0; j < tiles[i].length; j++) { 
        tiles[i][j].setNumber(gameBoard[i][j]);
        tiles[i][j].display(gameBoard[i][j] != 0 ? true : false);
      }
    }
  }
}
