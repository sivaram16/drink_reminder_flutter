import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'change_notification.dart';
import 'route.dart';

class OnBoard extends StatefulWidget {
  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  int a = 0;

  ect(double top) => Container(margin: EdgeInsets.only(top: top));
  ecl(double left) => Container(margin: EdgeInsets.only(left: left));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      body: _layout(),
    );
  }

  Widget _layout() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ect(70),
          Row(children: <Widget>[ecl(30), _startedText()]),
          ect(10),
          Row(children: <Widget>[ecl(30), _selectText()]),
          ect(20),
          Center(child: _selectLitre()),
          Center(child: _glassText()),
          ect(30),
          Container(
              padding: EdgeInsets.only(left: 80, right: 80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _minusButton(),
                  _addButton(),
                ],
              )),
          ect(150),
          Center(child: a == 0 ? Container() : _doneButton())
        ],
      )),
    );
  }

  Widget _startedText() {
    return Text(
      "Let's get started!",
      style: TextStyle(
          fontSize: 24,
          color: Color.fromRGBO(0, 153, 255, 1),
          fontFamily: 'Muli-Bold'),
    );
  }

  Widget _selectText() {
    return Text(
      "Select your daily target",
      style: TextStyle(fontSize: 18, fontFamily: 'Muli-Bold'),
    );
  }

  Widget _selectLitre() {
    return Text(
      "$a litres",
      style: TextStyle(
          fontSize: 80,
          color: Color.fromRGBO(126, 126, 126, 1),
          fontFamily: 'Muli-Bold'),
    );
  }

  Widget _glassText() {
    int b = a * 1000 ~/ 200;
    return Text(
      "$b glasses per day",
      style: TextStyle(
          fontSize: 18,
          color: Color.fromRGBO(0, 0, 0, 1),
          fontFamily: 'Muli-Bold'),
    );
  }

  Widget _minusButton() {
    return OutlineButton(
      onPressed: a == 0
          ? null
          : () {
              setState(() {
                a -= 1;
              });
            },
      child: Icon(
        Icons.remove,
        color: a == 0 ? Colors.grey : Colors.blue,
        size: 35.0,
      ),
      shape: CircleBorder(),
      padding: EdgeInsets.all(15.0),
    );
  }

  Widget _addButton() {
    return OutlineButton(
      onPressed: () {
        setState(() {
          a += 1;
        });
      },
      child: Icon(
        Icons.add,
        color: Colors.blue,
        size: 35.0,
      ),
      shape: CircleBorder(),
      padding: EdgeInsets.all(15.0),
    );
  }

  Widget _doneButton() {
    return RawMaterialButton(
      onPressed: () async {
        await _setSharedPref();
        Navigator.push(context, FadeRoute(page: Change()));
      },
      child: Icon(
        Icons.check,
        color: Colors.green,
        size: 35.0,
      ),
      shape: CircleBorder(),
      elevation: 2.0,
      fillColor: Colors.white,
      padding: EdgeInsets.all(15.0),
    );
  }

  _setSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('goal', a);
  }
}
