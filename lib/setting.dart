import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class setting extends StatefulWidget {
  @override
  _settingState createState() => _settingState();
}

class _settingState extends State<setting> {
  int go;

  ect(double top) => Container(margin: EdgeInsets.only(top: top));
  ecl(double left) => Container(margin: EdgeInsets.only(left: left));
  @override
  void initState() async {
    await _getPref();
    print("haii" + go.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _layout(),
    );
  }

  Widget _layout() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ect(50),
          Row(
            children: <Widget>[
              ecl(30),
              _back(),
            ],
          ),
          ect(30),
          Row(
            children: <Widget>[
              ecl(30),
              _settingText(),
            ],
          ),
          ect(20),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('/onBoard');
            },
            child: Row(
              children: <Widget>[
                ecl(30),
                _changeLimit(),
                Row(
                  children: <Widget>[ecl(60), _rightArrowIcon()],
                ),
              ],
            ),
          ),
          ect(30),
          InkWell(
            onTap: () {},
            child: Row(
              children: <Widget>[
                ecl(30),
                _changeNotification(),
                Row(
                  children: <Widget>[ecl(20), _rightArrowIcon()],
                ),
              ],
            ),
          ),
          ect(30),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                child: AlertDialog(
                  title: Text('Do you want to exit this application?'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('No'),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/onBoard");
                      },
                      child: Text('Yes'),
                    ),
                  ],
                ),
              );
            },
            child: Row(
              children: <Widget>[
                ecl(30),
                _reset(),
                Row(
                  children: <Widget>[ecl(110), _rightArrowIcon()],
                ),
              ],
            ),
          ),
          ect(30),
          InkWell(
            onTap: () {},
            child: Row(
              children: <Widget>[
                ecl(30),
                _theme(),
                Row(
                  children: <Widget>[ecl(80), _rightArrowIcon()],
                ),
              ],
            ),
          ),
          ect(30),
          InkWell(
            onTap: () {},
            child: Row(
              children: <Widget>[
                ecl(30),
                _about(),
                Row(
                  children: <Widget>[ecl(130), _rightArrowIcon()],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _back() {
    return Container(
      child: InkWell(
        child: Icon(Icons.keyboard_backspace),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget _settingText() {
    return Text(
      "Settings",
      style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 48),
    );
  }

  Widget _changelimitText() {
    return Text(
      "Change your daily target",
      style: TextStyle(color: Color.fromRGBO(0, 128, 255, 1), fontSize: 18),
    );
  }

  Widget _changelimitSubText() {
    return Text(
      "Currently set to 2 litres per day",
      style: TextStyle(color: Color.fromRGBO(93, 93, 93, 1), fontSize: 12),
    );
  }

  Widget _rightArrowIcon() {
    return Container(
      child: Icon(Icons.arrow_forward),
    );
  }

  Widget _changeLimit() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _changelimitText(),
        _changelimitSubText(),
      ],
    ));
  }

  Widget _changeNotificationText() {
    return Text(
      "Change notifications settings",
      style: TextStyle(color: Color.fromRGBO(0, 128, 255, 1), fontSize: 18),
    );
  }

  Widget _changeNotificationSubText() {
    return Text(
      "Edit your notifications settings",
      style: TextStyle(color: Color.fromRGBO(93, 93, 93, 1), fontSize: 12),
    );
  }

  Widget _changeNotification() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _changeNotificationText(),
          _changeNotificationSubText()
        ],
      ),
    );
  }

  Widget _resetText() {
    return Text(
      "Reset my account",
      style: TextStyle(color: Color.fromRGBO(0, 128, 255, 1), fontSize: 18),
    );
  }

  Widget _resetSubText() {
    return Text(
      "This will erase the app data",
      style: TextStyle(color: Color.fromRGBO(93, 93, 93, 1), fontSize: 12),
    );
  }

  Widget _themeText() {
    return Text(
      "Switch to Dark Theme",
      style: TextStyle(color: Color.fromRGBO(0, 128, 255, 1), fontSize: 18),
    );
  }

  Widget _themeSubText() {
    return Text(
      "Change app theme to dark mode",
      style: TextStyle(color: Color.fromRGBO(93, 93, 93, 1), fontSize: 12),
    );
  }

  Widget _aboutText() {
    return Text(
      "About app",
      style: TextStyle(color: Color.fromRGBO(0, 128, 255, 1), fontSize: 18),
    );
  }

  Widget _aboutSubText() {
    return Text(
      "View info about the app",
      style: TextStyle(color: Color.fromRGBO(93, 93, 93, 1), fontSize: 12),
    );
  }

  Widget _reset() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_resetText(), _resetSubText()],
      ),
    );
  }

  Widget _theme() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_themeText(), _themeSubText()],
      ),
    );
  }

  Widget _about() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_aboutText(), _aboutSubText()],
      ),
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
