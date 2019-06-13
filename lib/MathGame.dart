import 'dart:math';

class MathGame {
  GameType type;
  int max;
  int current;
  int paramA;
  int paramB;
  Range range;
  int right;
  static MathGame createPlusGame(int max,Range range) {
    return newMathGame(max, range,GameType.PLUS);
  }
  static MathGame createMiltyGame(int max, Range range) {
    return newMathGame(max, range,GameType.MILTY);
  }

  static MathGame newMathGame(int max, Range range,GameType type) {
    MathGame game = new MathGame();
    game.type = type;
    game.max=max;
    game.range=range;
    game.current=0;
    game.right=0;
    return game;
  }
  static MathGame createMinusGame(int max, Range range) {
    return newMathGame(max, range,GameType.MINUS);
  }

  getType() {
    return type;
  }

  hasNext() {
    return current<max;
  }

  getCurrent() {
    return current;
  }
  getMax(){
    return max;
  }

  String next() {
    current++;
    paramA = range.getRandom();
    paramB = range.getRandom();
    return paramA.toString()+getTypeChar()+paramB.toString();
  }

  score() {
    return right*100/max;
  }

  bool answer(int answer) {
    if(type==GameType.PLUS) {
      if (answer == paramB + paramA) {
        right++;
        return true;
      }
    }
    if(type==GameType.MINUS){
      if (answer == paramA - paramB) {
        right++;
        return true;
      }
    }
    if(type==GameType.MILTY){
      if (answer == paramA * paramB) {
        right++;
        return true;
      }
    }
    return false;
  }

  String getTypeChar() {
    switch(type){
      case GameType.PLUS:
        return "+";
      case GameType.MINUS:
        return "-";
      case GameType.MILTY:
        return "*";
    }
  }




}

class Range{
  int min;
  int max;

  Range(this.min, this.max);

  int getRandom() {
    var random = new Random();
    return min+random.nextInt(max-min);
  }

}
enum GameType {
  PLUS, MINUS, MILTY
}
