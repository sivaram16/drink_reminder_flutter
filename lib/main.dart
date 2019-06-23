import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme.dart';
import 'main_screen.dart';
import 'on_board.dart';
import 'setting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'about_app.dart';
import 'change_notification.dart';

void main() async => runApp(MyAppp());

class MyAppp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      builder: (_) => ThemeChanger(ThemeData.light()),
      child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatefulWidget {
  @override
  _MaterialAppWithThemeState createState() => _MaterialAppWithThemeState();
}

class _MaterialAppWithThemeState extends State<MaterialAppWithTheme> {
  bool authenticated = false;
  @override
  void initState() {
    super.initState();
    _getPref();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: authenticated ? MainScreen() : OnBoard(),
        theme: theme.getTheme(),
        routes: <String, WidgetBuilder>{
          '/mainscreen': (BuildContext context) => MainScreen(),
          '/setting': (BuildContext context) => Setting(),
          '/onBoard': (BuildContext context) => OnBoard(),
          '/change_notification': (BuildContext context) => Change(),
          '/aboutapp': (BuildContext context) => About(),
        });
  }

  _getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int goal = prefs.getInt('goal');
    setState(() {
      authenticated = goal != null;
    });
  }
}
