import 'dart:math';
import 'GameCounter.dart';
class MathGame {
  GameType type;
  MathType mathType;
  int paramA;
  int paramB;
  Range range;
  int max;
  int current;
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
    game.mathType=getMathType(type);
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

  getProgress() {
    return current;
  }
  getMax(){
    return max;
  }

  String next() {
    current++;
    paramA = range.getRandom();
    paramB = range.getRandom();
    return mathType.getQuestion(paramA, paramB);
  }


  score() {
    return right*100/max;
  }

  answer(int answer) {
    if (!checkAnswer(answer)) {
       wrongs.addWrong(mathType.getQuestion(paramA, paramB), getRightAnswer().toString(), answer.toString());
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
    return mathType.answer(paramA, paramB);
  }

  int getUsedTime() {
    return counter.score();
  }

  Wrongs wrongAnswer() {
    return wrongs;
  }

  static MathType getMathType(GameType type) {
    switch(type){
      case GameType.PLUS:
        return new PlusMath();
      case GameType.MINUS:
        return new MinusMath();
      case GameType.MILTY:
        return new MiltyMath();
    }
  }

  String getQuestion() {
    return mathType.getQuestion(paramA, paramB);
  }

  String rightCount() {
    return right.toString();
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
abstract class MathType{

  String getQuestion(int p1,int p2);
  int answer(int p1,int p2);
}
class PlusMath extends MathType{
  @override
  int answer(int p1, int p2) {
    return p1+p2;
  }

  @override
  String getQuestion(int p1, int p2) {
    return p1.toString()+"+"+p2.toString();
  }

}
class MinusMath extends MathType{
  @override
  int answer(int p1, int p2) {
    return p1-p2;
  }

  @override
  String getQuestion(int p1, int p2) {
    return p1.toString()+"-"+p2.toString();
  }


}
class MiltyMath extends MathType{
  @override
  int answer(int p1, int p2) {
    return p1*p2;
  }

  @override
  String getQuestion(int p1, int p2) {
    return p1.toString()+"*"+p2.toString();
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
