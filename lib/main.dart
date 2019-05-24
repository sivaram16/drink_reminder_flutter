import 'package:flutter/material.dart';
import 'Splashscreen.dart';
import 'setting.dart';
import 'onBoard.dart';
import 'mainscreen.dart';

void main() => runApp(MaterialApp(
      home: Splashscreen(),
      theme: ThemeData(fontFamily: 'Muli-Bold'),
      routes: <String, WidgetBuilder>{
        '/mainscreen': (BuildContext context) => mainscreen(),
        '/setting': (BuildContext context) => setting(),
        '/onBoard': (BuildContext context) => onBoard(),
      },
    ));
