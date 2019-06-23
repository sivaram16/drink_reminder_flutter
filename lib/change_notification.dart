import 'package:drink_remainder/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Change extends StatefulWidget {
  @override
  _ChangeState createState() => _ChangeState();
}

ect(double top) => Container(margin: EdgeInsets.only(top: top));
ecl(double left) => Container(margin: EdgeInsets.only(left: left));
int delay = 0, after;

class _ChangeState extends State<Change> {
  @override
  void initState() {
    super.initState();
    _getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        body: _layout());
  }

  Widget _layout() {
    return Container(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ect(150),
            Center(
              child: _notifyText(),
            ),
            Center(child: _glassText()),
            Container(
                padding: EdgeInsets.only(left: 80, right: 80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _minusButton(),
                    _addButton(),
                  ],
                )),
            ect(100),
            Center(child: _doneButton())
          ],
        ));
  }

  Widget _glassText() {
    return Text(
      "You will get notify every $delay Hour after your intake.",
      style: TextStyle(fontSize: 14, fontFamily: 'Muli-Bold'),
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
        Navigator.push(context, FadeRoute(page: MainScreen()));
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

  Widget _notifyText() {
    return Center(
        child: Text(
      "Notification Duration",
      style:
          TextStyle(fontSize: 28, color: Colors.blue, fontFamily: 'Muli-Bold'),
    ));
  }

  _getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int delayF = prefs.getInt('delay');
    delayF = delayF;
  }
}
