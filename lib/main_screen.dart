import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme.dart';
import 'package:provider/provider.dart';
import 'water_day_record.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int go = 0;
  List<WaterDayRecord> recordList = List<WaterDayRecord>();
  int delay;
  var now = new DateTime.now();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  double percent = 0;
  int count = 0;

  @override
  void initState() {
    super.initState();
    _getPref();
    _getDate();
    print("ram" + go.toString());
    print("delay" + delay.toString());
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = new IOSInitializationSettings();
    var initsetting = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(initsetting);
  }

  ect(double top) => Container(margin: EdgeInsets.only(top: top));
  ecl(double left) => Container(margin: EdgeInsets.only(left: left));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        body: _layout(),
        resizeToAvoidBottomPadding: false,
      ),
    );
  }

  Widget _layout() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_full(), _bottomCard()],
      ),
    );
  }

  Widget _full() {
    return Expanded(
      flex: 1,
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          ect(40),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[_setting()],
          ),
          _todayProgressText(),
          Row(
            children: <Widget>[
              _inTakeAmount(),
              ecl(20),
              Column(children: <Widget>[ect(20), _overAllAmount()]),
            ],
          ),
          _progress(),
          ect(10),
          Row(children: <Widget>[
            _statusWidget(_statusCount("0"), _statusText("day streak")),
            _statusWidget(
              _statusCount("4.5"),
              _statusText("litres drank\nso far"),
              color: Color.fromRGBO(0, 128, 255, 0.2),
            )
          ]),
          _previousRecords()
        ],
      ),
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

  Widget _todayProgressText() {
    return Text(
      "Today's progress",
      style: TextStyle(
          color: Color.fromRGBO(0, 128, 255, 1),
          fontSize: 24,
          fontFamily: 'Muli-Bold'),
    );
  }

  Widget _inTakeAmount() {
    return Text(
      "$count ml",
      style: TextStyle(
          color: Color.fromRGBO(0, 0, 0, 1),
          fontSize: 48,
          fontFamily: 'Muli-Bold'),
    );
  }

  Widget _overAllAmount() {
    return Text(
      "/ $go ml",
      style: TextStyle(
          color: Color.fromRGBO(143, 143, 143, 1),
          fontSize: 18,
          fontFamily: 'Muli-Bold'),
    );
  }

  Widget _progress() {
    return LinearPercentIndicator(
      lineHeight: 25.0,
      backgroundColor: Color.fromRGBO(223, 223, 223, 0.45),
      animation: true,
      animationDuration: 500,
      progressColor: Colors.blueAccent,
      percent: percent,
    );
  }

  Widget _statusWidget(Widget count, Widget text, {color}) {
    return Container(
      margin: EdgeInsets.only(left: 15),
      width: 140.0,
      height: 190.0,
      child: Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: <Widget>[ect(20), count, ect(30), text],
        ),
      ),
      decoration: new BoxDecoration(boxShadow: [
        new BoxShadow(
          color: color ?? Color.fromRGBO(255, 159, 159, 0.51),
          blurRadius: 16.0,
        ),
      ]),
    );
  }

  Widget _statusText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Color.fromRGBO(0, 0, 0, 1),
          fontSize: 18,
          fontFamily: 'Muli-Bold'),
    );
  }

  Widget _statusCount(String text) {
    return Text(
      text,
      style: TextStyle(
          color: Color.fromRGBO(0, 0, 0, 1),
          fontSize: 48,
          fontFamily: 'Muli-Bold'),
    );
  }

  _showNotification() async {
    var android = new AndroidNotificationDetails(
        "channelId", "channelName", "channelDescription");
    var ios = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, ios);
    await flutterLocalNotificationsPlugin.show(
        0, "It's time to drink", "Be Hydrate", platform);
  }

  Widget _previousRecords() {
    return Column(
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
            child: Container(
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ect(20),
                    _statsText(),
                    ect(30),
                    ListView.separated(
                      padding: EdgeInsets.only(left: 20),
                      shrinkWrap: true,
                      itemCount: 5,
                      separatorBuilder: (context, i) => ect(10),
                      itemBuilder: (context, index) => _oldRecord(),
                    )
                  ],
                )),
          ),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
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
      style: TextStyle(
          fontSize: 14,
          color: Color.fromRGBO(0, 0, 0, 1),
          fontFamily: 'Muli-Bold'),
    );
  }

  Widget _statsText() {
    return Text(
      "Your stats",
      style: TextStyle(
          color: Color.fromRGBO(152, 152, 152, 1),
          fontSize: 18,
          fontFamily: 'Muli-Bold'),
    );
  }

  _getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int goal = prefs.getInt('goal');
    int delayF = prefs.getInt('delay');
    String recordData = prefs.getString('records');
    if (recordData != null) {
      recordList = parseRecordListFromString(recordData);
    } else {
      recordList.add(WaterDayRecord(now, 0));
    }
    print('goal: $goal');
    print('record: $recordData');
    setState(() {
      go = goal * 1000;
      delay = delayF;
      count = getTodayFromRecordList(recordList).intake;
      if (count > go) {
        percent = 1.0;
      } else {
        percent = count / go;
      }
    });
  }

  Widget _bottomCard() {
    return Center(
        child: Container(
      width: 330.0,
      height: 100.0,
      child: Card(
        color: Color.fromRGBO(10, 128, 255, 1),
        elevation: 8.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[_addingItems()],
        )),
      ),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.16),
          blurRadius: 16.0,
        ),
      ]),
    ));
  }

  Widget _addingItems() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _addEntryButton(100, "assets/images/onezerozero.svg"),
        _addEntryButton(200, "assets/images/twozerozero.svg"),
        _addEntryButton(1000, "assets/images/onezerozerozero.svg")
      ],
    );
  }

  Widget _addEntryButton(int ml, String svg) {
    return Container(
        height: 65,
        width: 65,
        child: RawMaterialButton(
          shape: CircleBorder(),
          elevation: 2.0,
          fillColor: Colors.white,
          padding: EdgeInsets.all(15.0),
          onPressed: () {
            Future.delayed(Duration(seconds: delay), () {
              _showNotification();
            });
            setState(() {
              count += ml;
              if (count > go) {
                percent = 1.0;
              } else {
                percent = count / go;
              }
              recordList = updateTodayIntakeInRecordList(count, recordList);
              print('${recordList.last.date} ${recordList.last.intake}');
            });
            updateSharedPrefRecord(recordList);
          },
          child: Column(
            children: <Widget>[
              SvgPicture.asset(
                "$svg",
                height: 21,
                width: 20,
              ),
              ect(2),
              Text(
                "$ml ml",
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 8,
                    fontFamily: 'Muli-Bold'),
              )
            ],
          ),
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

  _getDate() {
    return DateFormat("yyyy-MM-dd").format(now);
  }

  void updateSharedPrefRecord(List<WaterDayRecord> recordList) async {
    String recordAsString = convertRecordListToString(recordList);
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('records', recordAsString);
    print("Updated record string in shared: $recordAsString");
    pref.commit();
  }
}