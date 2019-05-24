import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';

class mainscreen extends StatefulWidget {
  @override
  _mainscreenState createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> {
  int go = 0;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    _getPref();
    print("ram" + go.toString());
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = new IOSInitializationSettings();
    var initsetting = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(initsetting);
  }

  ect(double top) => Container(margin: EdgeInsets.only(top: top));
  ecl(double left) => Container(margin: EdgeInsets.only(left: left));

  double percent = 0;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => _exitApp(context),
        child: Scaffold(
          body: _layout(),
          resizeToAvoidBottomPadding: false,
        ));
  }

  Widget _layout() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _full(),
        ],
      ),
    );
  }

  Widget _progress() {
    return Container(
        margin: EdgeInsets.only(left: 30, right: 30),
        child: LinearPercentIndicator(
          lineHeight: 25.0,
          backgroundColor: Color.fromRGBO(223, 223, 223, 0.45),
          animation: true,
          animationDuration: 500,
          progressColor: Colors.blueAccent,
          percent: percent,
        ));
  }

  Widget _addtwozerozero() {
    return Container(
        child: RaisedButton(
      onPressed: () {
        Future.delayed(Duration(seconds: 5), () {
          _showNotification();
        });
        setState(() {
          count += 200;
          percent = double.parse(percent.toStringAsPrecision(2)) + 200 / go;
        });
      },
      child: Text("Add"),
    ));
  }

  Widget _addonezerozero() {
    return Container(
        child: RaisedButton(
      onPressed: () {
        Future.delayed(Duration(seconds: 5), () {
          _showNotification();
        });
        setState(() {
          count += 100;
          percent = double.parse(percent.toStringAsPrecision(2)) + 200 / go;
        });
      },
      child: Text("Add"),
    ));
  }

  Widget _addonezerozerozero() {
    return Container(
        child: RaisedButton(
      onPressed: () {
        Future.delayed(Duration(seconds: 5), () {
          _showNotification();
        });
        setState(() {
          count += 1000;
          percent = double.parse(percent.toStringAsPrecision(2)) + 200 / go;
        });
      },
      child: Text("Add"),
    ));
  }

  _showNotification() async {
    var android = new AndroidNotificationDetails(
        "channelId", "channelName", "channelDescription");
    var ios = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, ios);
    await flutterLocalNotificationsPlugin.show(
        0, "It's time to drink", "Be Hydrate", platform);
  }

  Widget _todayProgressText() {
    return Text(
      "Today's progress",
      style: TextStyle(color: Color.fromRGBO(0, 128, 255, 1), fontSize: 24),
    );
  }

  Widget _setting() {
    return Container(
      child: InkWell(
        child: Icon(Icons.settings),
        onTap: () {
          Navigator.of(context).pushNamed('/setting');
        },
      ),
    );
  }

  Widget _inTakeAmount() {
    return Text(
      "$count ml",
      style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 48),
    );
  }

  Widget _overAllAmount() {
    return Text(
      "/ $go ml",
      style: TextStyle(color: Color.fromRGBO(143, 143, 143, 1), fontSize: 18),
    );
  }

  Widget _dayStreak() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 10, 15, 30),
      width: 150.0,
      height: 200.0,
      child: Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
              child: Column(
            children: <Widget>[_daysstreakCount(), ect(30), _daysstreakText()],
          )),
        ),
      ),
      decoration: new BoxDecoration(boxShadow: [
        new BoxShadow(
          color: Color.fromRGBO(255, 159, 159, 0.51),
          blurRadius: 16.0,
        ),
      ]),
    );
  }

  Widget _daysstreakText() {
    return Text(
      "days streak",
      style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 18),
    );
  }

  Widget _daysstreakCount() {
    return Text(
      "0",
      style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 48),
    );
  }

  Widget _sofarRecord() {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 10, 15, 30),
      width: 150.0,
      height: 200.0,
      child: Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
              child: Column(
            children: <Widget>[_sofarCount(), ect(30), _sofarText()],
          )),
        ),
      ),
      decoration: new BoxDecoration(boxShadow: [
        new BoxShadow(
          color: Color.fromRGBO(0, 128, 255, 0.2),
          blurRadius: 16.0,
        ),
      ]),
    );
  }

  Widget _sofarText() {
    return Text(
      "litres drank so far",
      textAlign: TextAlign.center,
      style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 18),
    );
  }

  Widget _sofarCount() {
    return Text(
      "4.5",
      style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 48),
    );
  }

  Widget _previousRecords() {
    return ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(10, 10, 15, 30),
          width: 330.0,
          height: 260.0,
          child: Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ect(10),
                  _statsText(),
                  ect(30),
                  Column(
                    children: <Widget>[
                      ecl(50),
                      _oldRecord(),
                      ect(10),
                      _oldRecord(),
                      ect(10),
                      _oldRecord(),
                      ect(10),
                      _oldRecord(),
                      ect(10),
                      _oldRecord(),
                    ],
                  )
                ],
              )),
            ),
          ),
          decoration: new BoxDecoration(boxShadow: [
            new BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.16),
              blurRadius: 16.0,
            ),
          ]),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(1, 30, 1, 30),
          width: 345.0,
          height: 110.0,
          child: Card(
            color: Color.fromRGBO(10, 128, 255, 1),
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _addingItems(),
                ],
              )),
            ),
          ),
          decoration: new BoxDecoration(boxShadow: [
            new BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.16),
              blurRadius: 16.0,
            ),
          ]),
        ),
      ],
    );
  }

  Widget _oldRecord() {
    return Text(
      "17/05/2019 - 2300 ml / 2000ml",
      style: TextStyle(fontSize: 14, color: Color.fromRGBO(0, 0, 0, 1)),
    );
  }

  Widget _statsText() {
    return Text(
      "Your stats",
      style: TextStyle(color: Color.fromRGBO(152, 152, 152, 1), fontSize: 18),
    );
  }

  _getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int goal = prefs.getInt('goal');
    setState(() {
      go = goal * 1000;
    });
  }

  Widget _addingItems() {
    return Center(
        child: Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _oneZeroZero(),
          Row(
            children: <Widget>[
              ecl(60),
            ],
          ),
          _twoZeroZero(),
          Row(
            children: <Widget>[
              ecl(50),
            ],
          ),
          _oneZeroZeroZero(),
        ],
      ),
    ));
  }

  Widget _oneZeroZero() {
    return Container(
        height: 65,
        width: 65,
        child: RawMaterialButton(
          onPressed: () {
            print("pressed");
            Future.delayed(Duration(seconds: 5), () {
              _showNotification();
            });
            setState(() {
              count += 100;
              percent = double.parse(percent.toStringAsPrecision(2)) + 100 / go;
            });
          },
          child: Column(
            children: <Widget>[
              SvgPicture.asset("assets/images/onezerozero.svg"),
              Text(
                "100 ml",
                style:
                    TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 8),
              )
            ],
          ),
          shape: CircleBorder(),
          elevation: 2.0,
          fillColor: Colors.white,
          padding: EdgeInsets.all(15.0),
        ));
  }

  Widget _twoZeroZero() {
    return Container(
        height: 65,
        width: 65,
        child: RawMaterialButton(
          onPressed: () {
            Future.delayed(Duration(seconds: 5), () {
              _showNotification();
            });
            setState(() {
              count += 200;
              percent = double.parse(percent.toStringAsPrecision(2)) + 200 / go;
            });
          },
          child: Column(
            children: <Widget>[
              SvgPicture.asset(
                "assets/images/twozerozero.svg",
                height: 21,
                width: 20,
              ),
              Text(
                "200 ml",
                style:
                    TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 8),
              )
            ],
          ),
          shape: CircleBorder(),
          elevation: 2.0,
          fillColor: Colors.white,
          padding: EdgeInsets.all(15.0),
        ));
  }

  Widget _oneZeroZeroZero() {
    return Container(
        height: 65,
        width: 65,
        child: RawMaterialButton(
          onPressed: () {
            Future.delayed(Duration(seconds: 5), () {
              _showNotification();
            });
            setState(() {
              count += 1000;
              percent =
                  double.parse(percent.toStringAsPrecision(2)) + 1000 / go;
            });
          },
          child: Column(
            children: <Widget>[
              SvgPicture.asset(
                "assets/images/onezerozerozero.svg",
                height: 20,
                width: 20,
              ),
              Text(
                "1000 ml",
                style:
                    TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 8),
              )
            ],
          ),
          shape: CircleBorder(),
          elevation: 2.0,
          fillColor: Colors.white,
          padding: EdgeInsets.all(15.0),
        ));
  }

  Future<bool> _exitApp(BuildContext context) {
    return showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Do you want to exit this application?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => exit(0),
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  Widget _full() {
    return Expanded(
        flex: 1,
        child: Column(
          children: <Widget>[
            ect(40),
            Row(
              children: <Widget>[
                ecl(320),
                _setting(),
              ],
            ),
            Row(
              children: <Widget>[
                ecl(20),
                _todayProgressText(),
              ],
            ),
            Row(
              children: <Widget>[
                ecl(20),
                _inTakeAmount(),
                ecl(40),
                Column(
                  children: <Widget>[
                    ect(20),
                    _overAllAmount(),
                  ],
                ),
              ],
            ),
            _progress(),
            ect(10),
            Row(
              children: <Widget>[
                _dayStreak(),
                _sofarRecord(),
              ],
            ),
            Row(
              children: <Widget>[ecl(5), _previousRecords()],
            ),
          ],
        ));
  }
}
