import 'dart:math';
import 'GameCounter.dart';
class CubeGame {
  GameMatrix _matrix;
  GameStatus _status;

  CubeGame.newGame(int size) {
    this._matrix = new GameMatrix.newMatrix(size);
    _status = new GameStatus.newInstance();
  }

  bool checkNum(int num) {
    if (_status.isOver()) {
      return false;
    }
    return _checkNum(num);
  }

  bool _checkNum(int num) {
    if (_matrix.checkNum(num)) {
      _checkGameOver();
      return true;
    }
    return false;
  }

  void _checkGameOver() {
    if (_matrix.isOver()) {
      _status.finishGame();
    }
  }

  isOver() {
    return _status.isOver();
  }

  size() {
    return _matrix.size();
  }

  score() {
    return new GameScore(_status.score());
  }

  int number(int index) {
    return _matrix.numberAt(index);
  }
}

class GameStatus {
  GameCounter gameCounter;
  GameRunning gameRunning;

  GameStatus.newInstance() {
    gameCounter = new GameCounter.start(DateTime.now());
    gameRunning = new GameRunning(true);
  }

  bool isOver() {
    return gameRunning.isOver();
  }

  void finishGame() {
    gameRunning = new GameRunning(false);
    gameCounter.finishGame();
  }

  int score() {
    if (gameCounter == null) {
      return 0;
    }
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
    cursor = new GameCursor.newInstance();
  }

  bool checkNum(int num) {
    bool result = cursor.checkNum(num);
    if (result) {
      cursor.next();
    }
    return result;
  }

  bool isOver() {
    return cursor.cursor >= numbers.size();
  }

  int size() {
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
    List<int> numbers = new List<int>.generate(size * size, (i) => i + 1);
    numbers.shuffle();
    return numbers;
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

  GameCursor.newInstance() {
    cursor = 0;
  }

  bool checkNum(int num) {
    return cursor + 1 == num;
  }

  next() {
    cursor++;
  }
}



class GameScore {
  int time;

  GameScore(this.time);

  String toString() {
    return (time ~/ 1000).toString() + "." + (time % 1000).toString();
  }
}
