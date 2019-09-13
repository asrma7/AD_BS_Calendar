import 'package:ad_bs_calendar/ad_bs_calendar.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("CalendarDemo"),
          centerTitle: true,
        ),
        body: ADBSCalendar(
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
        ),
      ),
    );
  }
}
