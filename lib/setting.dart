import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  int go, delay = 0;
  bool isdark = false;

  ect(double top) => Container(margin: EdgeInsets.only(top: top));
  ecl(double left) => Container(margin: EdgeInsets.only(left: left));
  @override
  void initState() {
    _getPref();
    _setSharedPref();
    print(go.toString());
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
            child: Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[_changeLimit(), _rightArrowIcon()],
                )),
          ),
          ect(30),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('/change_notification');
            },
            child: Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[_changeNotification(), _rightArrowIcon()],
                )),
          ),
          ect(30),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                child: AlertDialog(
                  title: Text(
                    'Do you want to erase the data?',
                    style: TextStyle(fontFamily: 'Muli-Bold'),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(
                        'No',
                        style: TextStyle(fontFamily: 'Muli-Bold'),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/onBoard");
                      },
                      child: Text(
                        'Yes',
                        style: TextStyle(fontFamily: 'Muli-Bold'),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[_reset(), _rightArrowIcon()],
                )),
          ),
          ect(30),
          InkWell(
            onTap: () {
              ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
              _themeChanger.setTheme(
                  _themeChanger.getTheme() == ThemeData.dark()
                      ? ThemeData.light()
                      : ThemeData.dark());
            },
            child: Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[_theme(context), _rightArrowIcon()],
                )),
          ),
          ect(30),
          InkWell(
            onTap: () {},
            child: Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[_about(), _rightArrowIcon()],
                )),
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
      style: TextStyle(
          color: Color.fromRGBO(0, 0, 0, 1),
          fontSize: 48,
          fontFamily: 'Muli-Bold'),
    );
  }

  Widget _changelimitText() {
    return Text(
      "Change your daily target",
      style: TextStyle(
          color: Color.fromRGBO(0, 128, 255, 1),
          fontSize: 18,
          fontFamily: 'Muli-Bold'),
    );
  }

  Widget _changelimitSubText() {
    return Text(
      "Currently set to $go litres per day",
      style: TextStyle(
          color: Color.fromRGBO(93, 93, 93, 1),
          fontSize: 12,
          fontFamily: 'Muli-Bold'),
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
      style: TextStyle(
          color: Color.fromRGBO(0, 128, 255, 1),
          fontSize: 18,
          fontFamily: 'Muli-Bold'),
    );
  }

  Widget _changeNotificationSubText() {
    return Text(
      "Edit your notifications settings",
      style: TextStyle(
          color: Color.fromRGBO(93, 93, 93, 1),
          fontSize: 12,
          fontFamily: 'Muli-Bold'),
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
      style: TextStyle(
          color: Color.fromRGBO(0, 128, 255, 1),
          fontSize: 18,
          fontFamily: 'Muli-Bold'),
    );
  }

  Widget _resetSubText() {
    return Text(
      "This will erase the app data",
      style: TextStyle(
          color: Color.fromRGBO(93, 93, 93, 1),
          fontSize: 12,
          fontFamily: 'Muli-Bold'),
    );
  }

  Widget _themeText(String t) {
    return Text(
      "$t",
      style: TextStyle(
          color: Color.fromRGBO(0, 128, 255, 1),
          fontSize: 18,
          fontFamily: 'Muli-Bold'),
    );
  }

  Widget _themeSubText(String text) {
    return Text(
      "$text",
      style: TextStyle(
          color: Color.fromRGBO(93, 93, 93, 1),
          fontSize: 12,
          fontFamily: 'Muli-Bold'),
    );
  }

  Widget _aboutText() {
    return Text(
      "About app",
      style: TextStyle(
          color: Color.fromRGBO(0, 128, 255, 1),
          fontSize: 18,
          fontFamily: 'Muli-Bold'),
    );
  }

  Widget _aboutSubText() {
    return Text(
      "View info about the app",
      style: TextStyle(
          color: Color.fromRGBO(93, 93, 93, 1),
          fontSize: 12,
          fontFamily: 'Muli-Bold'),
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

  Widget _theme(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _themeChanger.getTheme() == ThemeData.dark()
              ? _themeText("Switch to Light Theme")
              : _themeText("Switch to Dark Theme"),
          _themeChanger.getTheme() == ThemeData.dark()
              ? _themeSubText("Change app theme to light mode")
              : _themeSubText("Change app theme to dark mode"),
        ],
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
      go = goal * 1000;
    });
  }

  _setSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', isdark);
  }
}
