import 'package:flutter/material.dart';
import 'dart:async';

class MathPage extends StatefulWidget {
  MathPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MathPageState createState() => _MathPageState(false);
}

class _MathPageState extends State<MathPage> {
  bool _waiting;

  _MathPageState(this._waiting);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
