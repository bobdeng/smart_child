import 'package:flutter/material.dart';
import 'dart:async';

class CubePage extends StatefulWidget {
  CubePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CubePageState createState() => _CubePageState(false);
}

class _CubePageState extends State<CubePage> {
  bool _waiting;

  _CubePageState(this._waiting);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
