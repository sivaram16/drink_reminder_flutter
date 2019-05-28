import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme.dart';
import 'Splashscreen.dart';
import 'main_screen.dart';
import 'on_board.dart';
import 'setting.dart';
import 'about_app.dart';
import 'change_notification.dart';

void main() async => runApp(MyAppp());

class MyAppp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      builder: (_) => ThemeChanger(ThemeData.light()),
      child: new MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);

    return MaterialApp(
      home: Splashscreen(),
      theme: theme.getTheme(),
      routes: <String, WidgetBuilder>{
        '/mainscreen': (BuildContext context) => MainScreen(),
        '/setting': (BuildContext context) => Setting(),
        '/onBoard': (BuildContext context) => OnBoard(),
        '/change_notification': (BuildContext context) => Change(),
        '/aboutapp': (BuildContext context) => About(),
      },
    );
  }
}
