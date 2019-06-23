import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
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
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        ect(50),
        Row(
          children: <Widget>[
            ecl(30),
            _back(),
          ],
        ),
        ect(10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _pic(),
          ],
        ),
        ect(50),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _text(
                "An app to help you hydrate.",
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                18),
          ],
        ),
        ect(20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _text("Developed By", Color.fromRGBO(0, 128, 255, 1), 18),
          ],
        ),
        ect(10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _text(
                "Sivaram S",
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                18),
          ],
        ),
        ect(40),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _text(
                "With design from",
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                14)
          ],
        ),
        ect(10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _text(
                "Roshan",
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                18)
          ],
        ),
        ect(50),
        Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _text(
                    "Made with ",
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    24),
                _text("Flutter", Color.fromRGBO(0, 128, 255, 1), 24),
                _text(".", Colors.black, 24)
              ],
            )),
      ],
    ));
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

  Widget _text(String text, Color colors, double size) {
    return Text(
      "$text",
      style: TextStyle(
        color: colors,
        fontSize: size,
        fontFamily: 'Muli-Bold',
      ),
    );
  }

  Widget _pic() {
    return ClipOval(
      child: Image.asset(
        'assets/images/pic.png',
        height: 200,
        width: 200,
        fit: BoxFit.cover,
      ),
    );
  }
}
