import 'package:flutter/material.dart';
import 'package:smart_child/MathGame.dart';
import 'dart:async';

class MathGameResultPage extends StatefulWidget {
  MathGame game;

  MathGameResultPage({Key key, this.title, this.game}) : super(key: key);

  final String title;

  @override
  _MathGameResultPageState createState() => _MathGameResultPageState(false);
}

class _MathGameResultPageState extends State<MathGameResultPage> {
  bool _waiting;

  _MathGameResultPageState(this._waiting);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("测试结果"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("得分：" + widget.game.score().toString(),textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30)),
          Text("耗时：" + (widget.game.getUsedTime() / 1000).toString(),textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30)),
          ListView.builder(
              shrinkWrap:true,
              itemCount: widget.game.wrongs.size(),
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: <Widget>[
                    Text(widget.game.wrongs.get(index).question+"=",textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30)),
                    Text(widget.game.wrongs.get(index).wrong,textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.redAccent,
                          fontStyle: FontStyle.italic,
                        )),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(widget.game.wrongs.get(index).right,textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30,color: Colors.green)),
                    ),

                  ],
                );
              })
        ],
      ),
    );
  }
}
