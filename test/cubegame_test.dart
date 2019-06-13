import 'package:test/test.dart';

import 'package:smart_child/CubeGame.dart';

void main() {
  test("run ganme", (){
    testCubeGame(5);
    testCubeGame(3);
    testCubeGame(9);
  });
}

void testCubeGame(int size) {
  var cubeGame = CubeGame.newGame(size);
  expect(cubeGame.size(), size*size);
  expect(cubeGame.score()!=null, true);
  for(int i=0;i<size*size;i++){
    guess(cubeGame,i+1);
  }
  expect(cubeGame.isOver(),true);
}

void guess(CubeGame cubeGame,int num) {
  expect(cubeGame.checkNum(num+1), false);
  expect(cubeGame.checkNum(num-1), false);
  expect(cubeGame.checkNum(num), true);
}
