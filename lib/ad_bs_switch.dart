import 'package:flutter/material.dart';

import './format.dart';

typedef OnChange(format);

class ADBSSwitch extends StatefulWidget {
  final Format format;
  final OnChange onChange;
  ADBSSwitch({this.format = Format.AD, this.onChange});
  @override
  _ADBSSwitchState createState() => _ADBSSwitchState();
}

class _ADBSSwitchState extends State<ADBSSwitch> {
  Format format;
  @override
  void initState() {
    format = widget.format;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedPositioned(
          duration: Duration(milliseconds: 200),
          left: format == Format.AD ? 0 : 30,
          child: Container(
            height: 28.0,
            width: 28.0,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
        GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    "AD",
                    style: TextStyle(
                      color: format == Format.AD ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    "BS",
                    style: TextStyle(
                      color: format == Format.BS ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            setState(() {
              format = format == Format.AD ? Format.BS : Format.AD;
            });
            widget.onChange(format);
          },
        ),
      ],
    );
  }
}
