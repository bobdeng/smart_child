import 'dart:math';

class CubeGame {
  GameMatrix matrix;
  GameStatus status;

  CubeGame.newGame(int size) {
    this.matrix = new GameMatrix.newMatrix(size);
    status = new GameStatus.newInstance();
  }

  bool checkNum(int num) {
    if (status.isOver()) {
      return false;
    }
    return doCheckNum(num);
  }

  bool doCheckNum(int num) {
    if(matrix.checkNum(num)){
      checkGameOver();
      return true;
    }
    return false;
  }

  void checkGameOver() {
    if (matrix.isOver()) {
      status.finishGame();
    }
  }

  isOver() {
    return status.isOver();
  }

  size() {
    return matrix.size();
  }

  score() {
    return status.score();
  }

  int number(int index) {
    return matrix.numberAt(index);
  }
}

class GameStatus {
  GameCounter gameCounter;
  GameRunning gameRunning;

  GameStatus(this.gameCounter, this.gameRunning);

  GameStatus.newInstance() {
    gameCounter = new GameCounter.start(DateTime.now());
    gameRunning = new GameRunning(true);
  }

  bool isOver() {
    return gameRunning.isOver();
  }

  void finishGame() {
    gameRunning=new GameRunning(false);
    gameCounter.finishGame();
  }

  score() {
    return gameCounter.score();
  }
}

class GameRunning {
  bool running;

  GameRunning(this.running);

  bool isOver() {
    return !running;
  }
}

class GameMatrix {
  GameNumbers numbers;
  GameCursor cursor;

  GameMatrix.newMatrix(int size) {
    numbers = new GameNumbers.newInstance(size);
    cursor = new GameCursor(0);
  }

  bool checkNum(int num) {
    return cursor.checkNum(num);
  }

  bool isOver() {
    return cursor.cursor>=numbers.size();
  }

  size() {
    return numbers.size();
  }

  int numberAt(int index) {
    return numbers.at(index);
  }
}

class GameNumbers {
  List<int> numbers;

  GameNumbers.newInstance(int size) {
    numbers = generateRandomNumbers(size);
  }

  List<int> generateRandomNumbers(int size) {
    List<int> numbers = [];
    for (int i = 1; i <= size * size; i++) {
      numbers.add(i);
    }
    numbers.shuffle();
    return numbers;
  }

  bool checkNum(int num, GameCursor cursor) {
    return num==numbers[cursor.cursor];
  }

  int size() {
    return numbers.length;
  }

  int at(int index) {
    return numbers[index];
  }
}

class GameCursor {
  int cursor;

  GameCursor(this.cursor);

  void next() {
    cursor++;
  }

  bool checkNum(int num) {
    if(cursor+1==num){
      cursor++;
      return true;
    }
    return false;
  }
}

class GameCounter {
  Timer start;
  Timer end;

  GameCounter.start(DateTime dateTime) {
    start = new Timer(dateTime);
  }

  void finishGame() {
    end=new Timer(DateTime.now());
  }

  score() {
    if(end==null) return 0;
    return end.minus(start);
  }
}

class Timer {
  DateTime time;

  Timer(DateTime dateTime) {
    time = dateTime;
  }

  int minus(Timer start) {
    return time.millisecondsSinceEpoch-start.time.millisecondsSinceEpoch;
  }
}
