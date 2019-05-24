import 'package:flutter/material.dart';

import 'Splashscreen.dart';
import 'main_screen.dart';
import 'on_board.dart';
import 'setting.dart';

void main() => runApp(MaterialApp(
      home: Splashscreen(),
      theme: ThemeData(fontFamily: 'Muli-Bold'),
      routes: <String, WidgetBuilder>{
        '/mainscreen': (BuildContext context) => MainScreen(),
        '/setting': (BuildContext context) => Setting(),
        '/onBoard': (BuildContext context) => OnBoard(),
      },
    ));
