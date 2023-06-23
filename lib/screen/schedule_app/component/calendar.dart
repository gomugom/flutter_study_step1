import 'package:flutter/material.dart';
import 'package:study/screen/schedule_app/constant/color.dart';
import 'package:table_calendar/table_calendar.dart';

// intl 사용을위해 불러와야하는 구문 => main에서 초기화하자
import 'package:intl/date_symbol_data_local.dart';

class Calendar extends StatefulWidget {

  final DateTime selectedDay;
  final DateTime focusedDay;
  final OnDaySelected onDaySelected;

  const Calendar({required this.selectedDay, required this.focusedDay, required this.onDaySelected, super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

  @override
  Widget build(BuildContext context) {

    final defaultDecoration = BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(6.0),
    );

    final defaultTextStyle = TextStyle(
      color: Colors.grey[600],
      fontWeight: FontWeight.w700,
    );

    return TableCalendar(
      locale: 'ko_KR', // 언어 설정
      focusedDay: widget.focusedDay,
      firstDay: DateTime(1800),
      lastDay: DateTime(3000),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
        ),
      ),
      calendarStyle: CalendarStyle(
        isTodayHighlighted: true,
        defaultDecoration: defaultDecoration,
        weekendDecoration: defaultDecoration,
        selectedDecoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(
              color: PRIMARY_SCHEDULE_COLOR,
              width: 1.0,
            )),
        defaultTextStyle: defaultTextStyle,
        weekendTextStyle: defaultTextStyle,
        selectedTextStyle: defaultTextStyle.copyWith(
          color: PRIMARY_SCHEDULE_COLOR,
        ),
        outsideDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
        ),
      ),
      onDaySelected: widget.onDaySelected,
      selectedDayPredicate: (day) {
        if (widget.selectedDay == null) return false;

        return day.year == widget.selectedDay!.year &&
            day.month == widget.selectedDay!.month &&
            day.day == widget.selectedDay!.day;
      },
    );
  }
}
