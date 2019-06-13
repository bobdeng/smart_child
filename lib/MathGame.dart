import 'dart:math';
import 'GameCounter.dart';
class MathGame {
  GameType type;
  int max;
  int current;
  int paramA;
  int paramB;
  Range range;
  int right;
  GameCounter counter;

  Wrongs wrongs;
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
    game.counter=GameCounter.start(DateTime.now());
    game.wrongs=new Wrongs();
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
    return getQuestion();
  }

  String getQuestion() => paramA.toString()+getTypeChar()+paramB.toString();

  score() {
    return right*100/max;
  }

  answer(int answer) {
    if (!checkAnswer(answer)) {
       wrongs.addWrong(getQuestion(), getRightAnswer().toString(), answer.toString());
    }
    if(!hasNext()){
      counter.finishGame();
    }
  }

  bool checkAnswer(int answer) {
    if(getRightAnswer()==answer){
      right++;
      return true;
    }
    return false;
  }

  int getRightAnswer() {
    int rightAnswer=0;
    if(type==GameType.PLUS) {
      rightAnswer= paramB + paramA;
    }
    if(type==GameType.MINUS){
      rightAnswer= paramA - paramB;
    }
    if(type==GameType.MILTY){
      rightAnswer= paramA * paramB;
    }
    return rightAnswer;
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

  int getUsedTime() {
    return counter.score();
  }

  Wrongs wrongAnswer() {
    return wrongs;
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
class Wrongs{
  List<Wrong> wrongs=[];

  Wrongs();
  
  void addWrong(String question,String right,String answer){
    wrongs.add(new Wrong(question, right, answer));
  }

  size() {
    return wrongs.length;
  }

}
class Wrong{
  String question;
  String right;
  String wrong;

  Wrong(this.question, this.right, this.wrong);

}
enum GameType {
  PLUS, MINUS, MILTY
}
