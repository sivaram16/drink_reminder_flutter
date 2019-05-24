import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      body: _layout(),
    );
  }

  Widget _layout() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ect(70),
          Row(children: <Widget>[ecl(30), _startedText()]),
          ect(10),
          Row(children: <Widget>[ecl(30), _selectText()]),
          ect(20),
          Center(child: _selectLitre()),
          Center(child: _glassText()),
          ect(30),
          Row(
            children: <Widget>[
              ecl(80),
              _minusButton(),
              ecl(30),
              _addButton(),
            ],
          ),
          ect(140),
          Center(child: _doneButton())
        ],
      )),
    );
  }

  Widget _startedText() {
    return Text(
      "Let's get started!",
      style: TextStyle(fontSize: 24, color: Color.fromRGBO(0, 153, 255, 1)),
    );
  }

  Widget _selectText() {
    return Text(
      "Select your daily target",
      style: TextStyle(fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
    );
  }

  Widget _selectLitre() {
    return Text(
      "$a litres",
      style: TextStyle(fontSize: 80, color: Color.fromRGBO(126, 126, 126, 1)),
    );
  }

  Widget _glassText() {
    int b = a * 1000 ~/ 200;
    return Text(
      "$b glasses per day",
      style: TextStyle(fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
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
        Navigator.of(context).pushNamed('/mainscreen');
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
