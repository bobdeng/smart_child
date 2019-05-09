import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:smart_child/CubeGame.dart';
import 'package:audioplayer/audioplayer.dart';
import 'package:path_provider/path_provider.dart';

class CubePage extends StatefulWidget {
  int size;

  CubePage({Key key, this.title, this.size}) : super(key: key);

  final String title;

  @override
  _CubePageState createState() => _CubePageState(5);
}

class _CubePageState extends State<CubePage> {
  int _size;
  bool playing=false;
  CubeGame _cubeGame;
  AudioPlayer audioPlayer;

  StreamSubscription<AudioPlayerState> _audioPlayerStateSubscription;

  _CubePageState(this._size);

  @override
  void initState() {
    setState(() {
      _cubeGame = CubeGame.newGame(_size);
    });
    initAudioPlayer();
    super.initState();
  }
  void initAudioPlayer() {
    audioPlayer = new AudioPlayer();
    _audioPlayerStateSubscription =
        audioPlayer.onPlayerStateChanged.listen((s) {
          if (s == AudioPlayerState.PLAYING) {
          } else if (s == AudioPlayerState.STOPPED) {
            playing=false;
          }
        }, onError: (msg) {
          playing=false;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Column(
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
        Visibility(
            visible: _cubeGame.isOver(),
            child: Opacity(
              child: ModalBarrier(
                color: Colors.grey,
                dismissible: false,
              ),
              opacity: 0.90,
            )),
        Visibility(
            visible: _cubeGame.isOver(),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "游戏结束",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30),
                        ),
                      )
                    ],
                  ),
                  Text("你的成绩：" + _cubeGame.score().toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30)),
                  RaisedButton(
                    child: Text("关闭"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ))
      ],
    ));
  }

  checkNum(num) {
    if (_cubeGame.checkNum(num)) {
      playSuccess();
      checkOver();
      return;
    }
    playFail();
  }

  void playSuccess() async {
    print("next");
    await playFile("success.mp3");
  }

  void playFail() async {
    print("fail");
    await playFile("fail.mp3");
  }

  void checkOver() {
    if (_cubeGame.isOver()) {
      setState(() {});
    }
  }

  Future playFile(soundFile) async {
    if(playing){
      await audioPlayer.stop();
    }
    playing=true;
    var file = await tryWriteFile(soundFile);
    await audioPlayer.play(file.path, isLocal: true);
  }

  Future<File> tryWriteFile(soundFile) async {
    final file =
        new File('${(await getTemporaryDirectory()).path}/' + soundFile);
    if (await file.exists()) {
      return file;
    }
    await file.writeAsBytes((await loadAsset(soundFile)).buffer.asUint8List());
    return file;
  }

  Future<ByteData> loadAsset(String file) async {
    return await rootBundle.load("assets/"+file);
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
                Text(
                  _number.toString(),
                  style: TextStyle(fontSize: 30),
                )
              ],
            )));
  }
}
