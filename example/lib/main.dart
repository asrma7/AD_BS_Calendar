import 'package:ad_bs_calendar/ad_bs_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ad_bs_calendar/format.dart';

void main() => initializeDateFormatting().then((_) => runApp(App()));

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Format format = Format.AD;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("CalendarDemo"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            children: <Widget>[
              ADBSSwitch(
                format: format,
                onChange: (f) {
                  setState(() {
                    format = f;
                  });
                },
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
                format: format,
                onPreviousMonth: () {
                  print("Previous");
                },
                onNextMonth: () {
                  print("Next");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
