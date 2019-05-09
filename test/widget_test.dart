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
    for(int i=0;i<25;i++){
      guess(cubeGame);
    }
    expect(cubeGame.isOver(),true);
    expect(cubeGame.score()>0,true);
  });
}

void guess(CubeGame cubeGame) {
  for(int i=0;i<25;i++){
    if(cubeGame.checkNum(i+1)){
      return;
    }
  }
}
