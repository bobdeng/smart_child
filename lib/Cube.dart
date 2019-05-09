import 'package:flutter/material.dart';
import 'dart:async';

import 'package:smart_child/CubeGame.dart';

class CubePage extends StatefulWidget {
  int size;

  CubePage({Key key, this.title, this.size}) : super(key: key);

  final String title;

  @override
  _CubePageState createState() => _CubePageState(5);
}

class _CubePageState extends State<CubePage> {
  int _size;
  CubeGame _cubeGame;

  _CubePageState(this._size);

  @override
  void initState() {
    setState(() {
      _cubeGame = CubeGame.newGame(_size);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _size),
                itemCount: _cubeGame.size(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return NumberBlock(_cubeGame.number(index), checkNum);
                }),
          ),
        ],
      ),
    );
  }

  checkNum(num) {
    if (_cubeGame.checkNum(num)) {
      playSuccess();
      checkOver();
      return;
    }
    playFail();
  }

  void playSuccess() {
    print("next");
  }

  void playFail() {
    print("fail");
  }

  void checkOver() {
    if(_cubeGame.isOver()){
      print("over:"+_cubeGame.score().toString());
    }
  }
}

class NumberBlock extends StatelessWidget {
  int _number;
  var _onpress;

  NumberBlock(this._number, this._onpress);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _onpress(_number);
        },
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(width: 0.5, color: Colors.black12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(_number.toString(),
                  style: TextStyle(
                      fontSize: 30
                  ),
                )
              ],
            )));
  }
}
