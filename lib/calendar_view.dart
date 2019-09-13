import './calendar_utils.dart';
import './ad_bs_switch.dart';
import './custom_icon_button.dart';
import './date_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nepali_utils/nepali_utils.dart';

import 'format.dart';

typedef OnPreviousMonth(month, format);
typedef OnNextMonth(month, format);
typedef OnSelectedDateChange(date);

class ADBSCalendar extends StatefulWidget {
  final List<DateTime> events, holidays;
  final OnPreviousMonth onPreviousMonth;
  final OnNextMonth onNextMonth;
  final OnSelectedDateChange onSelectedDateChange;
  final bool enableFormatSwitcher;
  final Format format;
  ADBSCalendar({
    this.events = const [],
    this.holidays = const [],
    this.format = Format.AD,
    this.enableFormatSwitcher = true,
    this.onSelectedDateChange,
    this.onPreviousMonth,
    this.onNextMonth,
  });
  @override
  _ADBSCalendarState createState() => _ADBSCalendarState();
}

class _ADBSCalendarState extends State<ADBSCalendar> {
  Format format;
  List<DateTime> _visibleDays;
  DateTime _focusedDate = DateTime.now();
  NepaliDateTime nt = NepaliDateTime.fromDateTime(DateTime.now());
  DateTime _selectedDate = DateTime.now();
  int _pageId = 0;
  double _dx = 0;
  Widget _buildtable() {
    int x = 0;
    final children = <TableRow>[
      TableRow(
        children: [
          Center(
            child: Text(
              "Sun",
              style: TextStyle(color: const Color(0xFF616161)),
            ),
          ),
          Center(
            child: Text(
              "Mon",
              style: TextStyle(color: const Color(0xFF616161)),
            ),
          ),
          Center(
            child: Text(
              "Tue",
              style: TextStyle(color: const Color(0xFF616161)),
            ),
          ),
          Center(
            child: Text(
              "Wed",
              style: TextStyle(color: const Color(0xFF616161)),
            ),
          ),
          Center(
            child: Text(
              "Thu",
              style: TextStyle(color: const Color(0xFF616161)),
            ),
          ),
          Center(
            child: Text(
              "Fri",
              style: TextStyle(color: const Color(0xFF616161)),
            ),
          ),
          Center(
            child: Text(
              "Sat",
              style: TextStyle(color: const Color(0xFFF44336)),
            ),
          ),
        ],
      ),
    ];
    while (x < _visibleDays.length) {
      List<Widget> _tableRows = _visibleDays
          .skip(x)
          .take(7)
          .toList()
          .map((date) => _buildTableCell(date))
          .toList();
      children.add(TableRow(children: _tableRows));
      x += 7;
    }
    return Table(
      children: children,
    );
  }

  List<DateTime> _daysInMonth(DateTime month) {
    final first = Utils.firstDayOfMonth(month);
    final daysBefore = first.weekday % 7;
    final firstToDisplay = first.subtract(Duration(days: daysBefore));

    final last = Utils.lastDayOfMonth(month);
    var daysAfter = 7 - last.weekday;
    if (daysAfter == 0) {
      daysAfter = 7;
    }

    final lastToDisplay = last.add(Duration(days: daysAfter));
    return Utils.daysInRange(firstToDisplay, lastToDisplay).toList();
  }

  Map<int, List<int>> nepaliMonthDays = initializeDaysInMonths();

  List<DateTime> _nepaliDaysInMonth(DateTime first, DateTime last) {
    final daysBefore = first.weekday % 7;
    final firstToDisplay = first.subtract(Duration(days: daysBefore));

    var daysAfter = 7 - last.weekday;
    if (daysAfter == 0) {
      daysAfter = 7;
    }

    final lastToDisplay = last.add(Duration(days: daysAfter));
    return Utils.daysInRange(firstToDisplay, lastToDisplay).toList();
  }

  Widget _buildTableCell(date) {
    NepaliDateTime nepalidate = NepaliDateTime.fromDateTime(date);
    bool condition = format == Format.BS
        ? (nepalidate.month < nt.month || nepalidate.month > nt.month)
        : (date.month < _focusedDate.month || date.month > _focusedDate.month);
    if (condition)
      return Container();
    else
      return GestureDetector(
        child: Center(
          child: Container(
            height: 30.0,
            width: 30.0,
            margin: EdgeInsets.symmetric(vertical: 5.0),
            decoration: (Utils.isSameDay(date, _selectedDate))
                ? BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(50.0),
                  )
                : (Utils.isSameDay(date, DateTime.now()))
                    ? BoxDecoration(
                        color: Color(0xFFB39DDB),
                        borderRadius: BorderRadius.circular(50.0),
                      )
                    : BoxDecoration(),
            child: Stack(
              children: <Widget>[
                Center(
                  child: Text(
                    format == Format.BS
                        ? NepaliDateFormat('d').format(nepalidate)
                        : DateFormat('d').format(date),
                    style: TextStyle(
                        color: DateFormat('E').format(date) == "Sat" ||
                                widget.holidays.contains(date)
                            ? const Color(0xFFF44336)
                            : (Utils.isSameDay(date, _selectedDate) ||
                                    Utils.isSameDay(date, DateTime.now()))
                                ? Colors.white
                                : const Color(0xFF616161)),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 3.0,
                    width: 10.0,
                    margin: EdgeInsets.only(bottom: 3.0),
                    color: widget.events.contains(date)
                        ? Colors.deepOrange
                        : Colors.transparent,
                  ),
                )
              ],
            ),
          ),
        ),
        onTap: () {
          setState(() {
            _selectedDate = date;
          });
          if (widget.onSelectedDateChange != null)
            widget.onSelectedDateChange(date);
        },
      );
  }

  @override
  void initState() {
    format = widget.format;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NepaliDateTime first = NepaliDateTime(nt.year, nt.month, 1);
    NepaliDateTime last =
        NepaliDateTime(nt.year, nt.month, nepaliMonthDays[nt.year][nt.month]);
    _visibleDays = format == Format.AD
        ? _daysInMonth(_focusedDate)
        : _nepaliDaysInMonth(first.toDateTime(), last.toDateTime());
    return Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                CustomIconButton(
                  padding: EdgeInsets.all(5.0),
                  margin: EdgeInsets.all(5.0),
                  icon: Icon(Icons.chevron_left),
                  onTap: _previousMonth,
                ),
                Text(
                  format == Format.AD
                      ? DateFormat.yMMMM('en_US').format(_focusedDate)
                      : indexToMonth(nt.month, Language.ENGLISH) +
                          " " +
                          nt.year.toString(),
                  style: TextStyle(fontSize: 17.0),
                  textAlign: TextAlign.start,
                ),
                widget.enableFormatSwitcher
                    ? Expanded(
                        child: Center(
                          child: ADBSSwitch(
                            format: format,
                            onChange: (f) {
                              setState(() {
                                format = f;
                              });
                            },
                          ),
                        ),
                      )
                    : Spacer(),
                CustomIconButton(
                  padding: EdgeInsets.all(5.0),
                  margin: EdgeInsets.all(5.0),
                  icon: Icon(Icons.chevron_right),
                  onTap: _nextMonth,
                ),
              ],
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              switchInCurve: Curves.decelerate,
              transitionBuilder: (child, animation) {
                return SlideTransition(
                  position:
                      Tween<Offset>(begin: Offset(_dx, 0), end: Offset(0, 0))
                          .animate(animation),
                  child: child,
                );
              },
              layoutBuilder: (currentChild, _) => currentChild,
              child: Dismissible(
                key: ValueKey(_pageId),
                child: _buildtable(),
                direction: DismissDirection.horizontal,
                resizeDuration: null,
                onDismissed: (DismissDirection d) {
                  if (d == DismissDirection.startToEnd)
                    _previousMonth();
                  else
                    _nextMonth();
                },
              ),
            ),
          ],
        ));
  }

  void _previousMonth() {
    setState(() {
      if (format == Format.AD) {
        int year =
            _focusedDate.month == 1 ? _focusedDate.year - 1 : _focusedDate.year;
        int month = _focusedDate.month == 1 ? 12 : _focusedDate.month - 1;
        _focusedDate = DateTime(year, month, _focusedDate.day);
        nt = NepaliDateTime.fromDateTime(_focusedDate);
      } else {
        int year = nt.month == 1 ? nt.year - 1 : nt.year;
        int month = nt.month == 1 ? 12 : nt.month - 1;
        nt = NepaliDateTime(year, month, nt.day);
        _focusedDate = nt.toDateTime();
      }
      _pageId--;
      _dx = -1.2;
      int month = format == Format.AD ? _focusedDate.month : nt.month;
      if (widget.onPreviousMonth != null) {
        widget.onPreviousMonth(month, format);
      }
    });
  }

  void _nextMonth() {
    setState(() {
      if (format == Format.AD) {
        int year = _focusedDate.month == 12
            ? _focusedDate.year + 1
            : _focusedDate.year;
        int month = _focusedDate.month == 12 ? 1 : _focusedDate.month + 1;
        _focusedDate = DateTime(year, month, _focusedDate.day);
        nt = NepaliDateTime.fromDateTime(_focusedDate);
      } else {
        int year = nt.month == 12 ? nt.year + 1 : nt.year;
        int month = nt.month == 12 ? 1 : nt.month + 1;
        nt = NepaliDateTime(year, month, nt.day);
        _focusedDate = nt.toDateTime();
      }
      _pageId++;
      _dx = 1.2;
      int month = format == Format.AD ? _focusedDate.month : nt.month;
      if (widget.onNextMonth != null) {
        widget.onNextMonth(month, format);
      }
    });
  }
}
