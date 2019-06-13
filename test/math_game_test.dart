import 'package:test/test.dart';
import 'dart:math';
import 'package:smart_child/MathGame.dart';

void main() {

  test("run math plus game", (){
    MathGame mathGame=MathGame.createPlusGame(100,new Range(20,50));
    expect(mathGame.getType(), GameType.PLUS);
      testGame(mathGame,(int a,int b){
        return a+b;
      },"+");
  });
  test("run math minus game", (){
    MathGame mathGame=MathGame.createMinusGame(100,new Range(20,50));
    expect(mathGame.getType(), GameType.MINUS);
    testGame(mathGame,(int a,int b){
      return a-b;
    },"-");
  });
  test("run math muilty game", (){
    MathGame mathGame=MathGame.createMiltyGame(100,new Range(20,50));
    expect(mathGame.getType(), GameType.MILTY);
    testGame(mathGame,(int a,int b){
      return a*b;
    },"*");
  });
}

void testGame(MathGame mathGame,int Function(int a, int b) compute,Pattern splitPattern) async{
  int start=DateTime.now().millisecondsSinceEpoch;
  expect(mathGame.getCurrent(), 0);
  expect(mathGame.getMax(), 100);
  expect(mathGame.hasNext(), true);
  var random = new Random();
  int score=0;
  int skew=0;
  while(mathGame.hasNext()){
    String problem=mathGame.next();
    var split = problem.split(splitPattern);
    expect(split.length, 2);
    expect(int.parse(split[0])>=20 && int.parse(split[0])<=50,true);
    if(random.nextInt(10)>5) {
      skew=1;
    }else{
      skew=0;
      score++;
    }
    mathGame.answer(
        compute(int.parse(split[0]), int.parse(split[1]))+skew);
    await Future.delayed(Duration(milliseconds: 1));
  }

  int count1=mathGame.getUsedTime();
  print(count1);
  expect(count1>0,true);
  expect(mathGame.score(), score);
  expect(mathGame.wrongAnswer().size(), 100-score);

}