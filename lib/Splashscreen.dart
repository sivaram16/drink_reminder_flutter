import 'package:drink_remainder/main_screen.dart';
import 'package:drink_remainder/on_board.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'route.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splashscreen(),
    );
  }
}

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  int go;
  @override
  void initState() {
    super.initState();
    _getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
    );
  }

  _getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int goal = prefs.getInt('goal');
    goal == null
        ? Future.delayed(Duration(seconds: 1), () {
            Navigator.push(context, FadeRoute(page: OnBoard()));
          })
        : Future.delayed(Duration(seconds: 1), () {
            Navigator.push(context, FadeRoute(page: MainScreen()));
          });
  }
}
