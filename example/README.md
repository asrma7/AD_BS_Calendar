# ad_bs_calendar_example

Demonstrates how to use the ad_bs_calendar plugin.

## Getting Started

#### USAGE

```dart
import 'package:ad_bs_calendar/ad_bs_calendar.dart';

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
    enableFormatSwitcher: true,
    nepaliDigits: true,
    onPreviousMonth: (month, format) {
        print("$month");
    },
    onFormatChange: (month, format) {
        print(format);
    },
    onNextMonth: (month, format) {
        print("$month");
    },
    onSelectedDateChange: (date) {
        print(date.toString());
    },
),
```