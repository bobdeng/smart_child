import 'dart:math';
import 'GameCounter.dart';

class MathGame {
  GameType type;
  MathType mathType;
  Parameters parameters;
  Range range;
  int max;
  int current;
  int right;
  GameCounter counter;

  Wrongs wrongs;

  static MathGame createPlusGame(int max, Range range) {
    return newMathGame(max, range, GameType.PLUS);
  }

  static MathGame createMiltyGame(int max, Range range) {
    return newMathGame(max, range, GameType.MILTY);
  }

  static MathGame newMathGame(int max, Range range, GameType type) {
    MathGame game = new MathGame();
    game.type = type;
    game.mathType = getMathType(type);
    game.max = max;
    game.range = range;
    game.current = 0;
    game.right = 0;
    game.counter = GameCounter.start(DateTime.now());
    game.wrongs = new Wrongs();
    return game;
  }

  static MathGame createMinusGame(int max, Range range) {
    return newMathGame(max, range, GameType.MINUS);
  }

  getType() {
    return type;
  }

  hasNext() {
    return current < max;
  }

  getProgress() {
    return current;
  }

  getMax() {
    return max;
  }

  String next() {
    current++;
    parameters = mathType.getRandomParameters(range);
    return mathType.getQuestion(parameters);
  }

  score() {
    return right * 100 / max;
  }

  answer(int answer) {
    if (!checkAnswer(answer)) {
      wrongs.addWrong(mathType.getQuestion(parameters),
          getRightAnswer().toString(), answer.toString());
    }
    if (!hasNext()) {
      counter.finishGame();
    }
  }

  bool checkAnswer(int answer) {
    if (getRightAnswer() == answer) {
      right++;
      return true;
    }
    return false;
  }

  int getRightAnswer() {
    return mathType.answer(parameters);
  }

  int getUsedTime() {
    return counter.score();
  }

  Wrongs wrongAnswer() {
    return wrongs;
  }

  static MathType getMathType(GameType type) {
    switch (type) {
      case GameType.PLUS:
        return new PlusMath();
      case GameType.MINUS:
        return new MinusMath();
      case GameType.MILTY:
        return new MiltyMath();
    }
  }

  String getQuestion() {
    return mathType.getQuestion(parameters);
  }

  String rightCount() {
    return right.toString();
  }
}

class Parameters {
  int paramA;
  int paramB;

  Parameters(this.paramA, this.paramB);

  int add() {
    return paramA + paramB;
  }
}

class Range {
  int min;
  int max;

  Range(this.min, this.max);

  int getRandom() {
    var random = new Random();
    return min + random.nextInt(max - min);
  }
}

abstract class MathType {
  String getQuestion(Parameters p);

  int answer(Parameters p);

  Parameters getRandomParameters(Range range) {
    return new Parameters(range.getRandom(), range.getRandom());
  }
}

class PlusMath extends MathType {
  @override
  int answer(Parameters p) {
    return p.add();
  }

  @override
  String getQuestion(Parameters p) {
    return p.paramA.toString() + "+" + p.paramB.toString();
  }
}

class MinusMath extends MathType {
  @override
  int answer(Parameters p) {
    return p.paramA - p.paramB;
  }

  @override
  String getQuestion(Parameters p) {
    return p.paramA.toString() + "-" + p.paramB.toString();
  }

  Parameters getRandomParameters(Range range) {
    int param1 = range.getRandom();
    int param2 = range.getRandom();
    return new Parameters(max(param1, param2), min(param1, param2));
  }
}

class MiltyMath extends MathType {
  @override
  int answer(Parameters p) {
    return p.paramB * p.paramA;
  }

  @override
  String getQuestion(Parameters p) {
    return p.paramA.toString() + "*" + p.paramB.toString();
  }
}

class Wrongs {
  List<Wrong> wrongs = [];

  Wrongs();

  void addWrong(String question, String right, String answer) {
    wrongs.add(new Wrong(question, right, answer));
  }

  size() {
    return wrongs.length;
  }

  Wrong get(int index) {
    return wrongs[index];
  }
}

class Wrong {
  String question;
  String right;
  String wrong;

  Wrong(this.question, this.right, this.wrong);

}

enum GameType { PLUS, MINUS, MILTY }
