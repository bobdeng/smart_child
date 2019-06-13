import 'package:flutter/material.dart';
import 'dart:async';

import 'package:smart_child/MathGame.dart';

class MathPage extends StatefulWidget {
  MathGame game;
  MathPage({Key key, this.title,this.game}) : super(key: key);

  final String title;

  @override
  _MathPageState createState() => _MathPageState(false);
}

class _MathPageState extends State<MathPage> {
  bool _waiting;
  String _answer="";
  List<KeyBoard> _keyboard=[
    new KeyBoard(null,"1"),
    new KeyBoard(null,"2"),
    new KeyBoard(null,"3"),
    new KeyBoard(null,"4"),
    new KeyBoard(null,"5"),
    new KeyBoard(null,"6"),
    new KeyBoard(null,"7"),
    new KeyBoard(null,"8"),
    new KeyBoard(null,"9"),
    new KeyBoard(Icons.backspace,"DELETE"),
    new KeyBoard(null,"0"),
    new KeyBoard(Icons.check,"OK")];
  _MathPageState(this._waiting);

  @override
  void initState() {
    widget.game.next();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("数学训练"),
      ),
      body: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("正确："+widget.game.rightCount(),textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30))
            ],
          ),
          LinearProgressIndicator(value: widget.game.getProgress()*1.0/widget.game.getMax(),),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(widget.game.getQuestion(),textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30)),
                Text("=",textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30)),
                Text(_answer==null?"":_answer,textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30))
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment:Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemCount: _keyboard.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      if(_keyboard[index].icon!=null) {
                        return new FlatButton(
                            onPressed: (){
                              if(_keyboard[index].char=="DELETE"){
                                if(_answer.length>0){
                                  setState(() {
                                    _answer=_answer.substring(0,_answer.length-1);
                                  });
                                }
                              }
                              if(_keyboard[index].char=="OK"){
                                setState(() {
                                  widget.game.answer(int.parse(_answer));
                                  widget.game.next();
                                  _answer="";
                                });

                              }
                            },
                            child: Icon(_keyboard[index].icon));
                      }
                      return new FlatButton(
                        onPressed:(){
                          setState(() {
                            _answer+=_keyboard[index].char;
                          });

                        },
                          child: Text(_keyboard[index].char,textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 30)));
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }

  String getProgressText() => widget.game.getProgress().toString()+"/"+widget.game.getMax().toString();
}

class KeyBoard {
  IconData icon;
  String char;

  KeyBoard(this.icon, this.char);

}
