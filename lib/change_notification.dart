import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Change extends StatefulWidget {
  @override
  _ChangeState createState() => _ChangeState();
}

ect(double top) => Container(margin: EdgeInsets.only(top: top));
ecl(double left) => Container(margin: EdgeInsets.only(left: left));
int delay = 0;

class _ChangeState extends State<Change> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _layout());
  }

  Widget _layout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ect(250),
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
    );
  }

  Widget _glassText() {
    // int b = a * 1000 ~/ 200;
    return Text(
      "$delay seconds",
      style: TextStyle(fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1),
          fontFamily: 'Muli-Bold'),
    );
  }

  Widget _minusButton() {
    return OutlineButton(
      onPressed: delay == 0
          ? null
          : () {
              setState(() {
                delay -= 1;
              });
            },
      child: Icon(
        Icons.remove,
        color: delay == 0 ? Colors.grey : Colors.blue,
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
          delay += 1;
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
    await prefs.setInt('delay', delay);
  }
}
