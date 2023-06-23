import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:study/screen/schedule_app/constant/color.dart';
import 'package:study/screen/schedule_app/database/drift_database.dart';
import 'package:study/screen/schedule_app/model/schedule_with_color.dart';

class TableBanner extends StatelessWidget {
  final DateTime selectedDay;

  const TableBanner(
      {required this.selectedDay, super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
    );

    return Container(
      color: PRIMARY_SCHEDULE_COLOR,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${selectedDay.year}년 ${selectedDay.month}월 ${selectedDay.day.toString().padLeft(2, '0')}일',
              style: textStyle,
            ),
            StreamBuilder<List<ScheduleWithColor>>(
              stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDay),
              builder: (context, snapshot) {

                int count = 0;

                if(snapshot.hasData) {
                  count = snapshot.data!.length;
                }

                return Text(
                  '$count개',
                  style: textStyle,
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
