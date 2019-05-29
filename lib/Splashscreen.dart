import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'water_day_record.dart';

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
  void initState() async {
    super.initState();
    await _getPref();
    print("siva" + go.toString());
    go == null
        ? Future.delayed(Duration(seconds: 5), () {
            Navigator.of(context).pushNamed('/onBoard');
          })
        : Future.delayed(Duration(seconds: 5), () {
            Navigator.of(context).pushNamed('/mainscreen');
          });
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
    setState(() {
      go = goal;
    });
  }
}
