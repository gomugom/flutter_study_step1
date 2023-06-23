import 'package:flutter/material.dart';

class DateTimeStudy extends StatelessWidget {
  DateTimeStudy({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    print(now);
    print(now.year);
    print(now.month);
    print(now.day);
    print(now.hour);
    print(now.minute);
    print(now.second);
    print(now.millisecond);

    Duration duration = Duration(seconds: 60);

    print(duration);
    print(duration.inDays); // 0
    print(duration.inHours); // 0
    print(duration.inMinutes); // 1
    print(duration.inSeconds); // 60
    print(duration.inMilliseconds); // 60000

    DateTime specificDays = DateTime(2017, 11, 23);
    print(specificDays);

    final difference = now.difference(specificDays);
    print(difference);
    print(difference.inDays);
    print(difference.inHours);

    print(now.isAfter(specificDays));
    print(now.isBefore(specificDays));

    now = now.add(Duration(hours: 10));
    print(now);

    now = now.subtract(Duration(seconds: 20));
    print(now);

    return const Placeholder();
  }
}
