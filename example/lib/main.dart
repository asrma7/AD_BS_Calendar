import 'package:ad_bs_calendar/ad_bs_calendar.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool nepaliDigits = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("CalendarDemo"),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RaisedButton(
                  child: Text("EN"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  onPressed: () {
                    setState(() {
                      nepaliDigits = false;
                    });
                  },
                ),
                RaisedButton(
                  child: Text("NP"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  onPressed: () {
                    setState(() {
                      nepaliDigits = true;
                    });
                  },
                ),
              ],
            ),
            ADBSCalendar(
              events: [
                DateTime.parse('2019-09-23'),
                DateTime.parse('2019-09-12'),
                DateTime.parse('2019-10-12'),
              ],
              holidays: [
                DateTime.parse('2019-09-27'),
                DateTime.parse('2019-09-01'),
              ],
              format: Format.AD,
              nepaliDigits: nepaliDigits,
            ),
          ],
        ),
      ),
    );
  }
}
