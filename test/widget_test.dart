// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:smart_child/CubeGame.dart';

void main() {
  test("run ganme", (){
    var cubeGame = CubeGame.newGame(5);
    expect(cubeGame.size(), 25);
    expect(cubeGame.score()!=null, true);
    cubeGame.start();
    for(int i=0;i<25;i++){
      guess(cubeGame,i+1);
    }
    expect(cubeGame.isOver(),true);
  });
}

void guess(CubeGame cubeGame,int num) {
  expect(cubeGame.checkNum(num+1), false);
  expect(cubeGame.checkNum(num-1), false);
  expect(cubeGame.checkNum(num), true);
}
