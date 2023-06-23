import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:study/screen/schedule_app/component/calendar.dart';
import 'package:study/screen/schedule_app/component/new_schedule_btn_sheet.dart';
import 'package:study/screen/schedule_app/component/schedule_card.dart';
import 'package:study/screen/schedule_app/component/table_banner.dart';
import 'package:study/screen/schedule_app/constant/color.dart';
import 'package:study/screen/schedule_app/database/drift_database.dart';
import 'package:study/screen/schedule_app/model/schedule_with_color.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleApp extends StatefulWidget {
  const ScheduleApp({super.key});

  @override
  State<ScheduleApp> createState() => _ScheduleAppState();
}

class _ScheduleAppState extends State<ScheduleApp> {
  // Calendar 통해서 selected할 경우 utc로 가져오기 때문에 둘의 timezone이 맞지 않음 따라서 일치시켜 줘야함(utc)
  DateTime selectedDay = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    initialIntl();
  }

  void initialIntl() async {
    await initializeDateFormatting(); // TableCalendar에서 locale : 'ko_KR' 사용을 위한 다국어 intl 초기화 설정
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: renderFloatingActionBtn(),
      body: SafeArea(
        child: Column(
          children: [
            Calendar(
              onDaySelected: onDaySelected,
              selectedDay: this.selectedDay,
              focusedDay: this.focusedDay,
            ),
            SizedBox(
              height: 8.0,
            ),
            TableBanner(
              selectedDay: this.selectedDay,
            ),
            SizedBox(
              height: 8.0,
            ),
            _ScheduleList(
              selectedDate: this.selectedDay
            ),
          ],
        ),
      ),
    );
  }

  onDaySelected(selectedDay, focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = selectedDay;
    });
  }

  FloatingActionButton renderFloatingActionBtn() {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          // 하단부 팝업창 느낌 => showCupertinoDialog도 있지만 이걸 더 많이씀
          context: context,
          isScrollControlled: true,
          // 이걸 설정해야 키보드 사이즈만큼 커져야할 때 커질수 있음=> default는 화면 반 이상 안되게 되어있음(모달은)
          builder: (context) {
            return NewScheduleBtnSheet(
              selectedDate: selectedDay,
            );
          },
        );
      },
      backgroundColor: PRIMARY_SCHEDULE_COLOR,
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}

class _ScheduleList extends StatelessWidget {

  final DateTime selectedDate;
  const _ScheduleList({required this.selectedDate, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: StreamBuilder<List<ScheduleWithColor>>(
          stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate), // stream으로 지속적으로 감시해 데이터 수령해옴
          builder: (context, snapshot) {

            //
            // List<ScheduleData> schedules = [];
            //
            // if(snapshot.hasData) { // List에 where가 있내...?
            //   schedules = snapshot.data!.where((element) => element.date.toUtc() == selectedDate).toList();
            // }

            if(!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            if(snapshot.hasData && snapshot.data!.isEmpty) {
              return Center(
                child: Text('스케쥴이 없습니다.'),
              );
            }

            return ListView.separated(
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) {
                // 각 항목 사이에 들어갈 항목
                return SizedBox(
                  height: 8.0,
                );
              },
              itemBuilder: (context, index) {

                final scheduleWithColor = snapshot.data![index];

                return Dismissible( // 오른쪽에서 왼쪽으로 스와이프해서 없애는 동작을 구현해주는 위젯
                  // key: Key(scheduleWithColor.scheduleData.id.toString()),
                  key: ObjectKey(scheduleWithColor.scheduleData.id),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    GetIt.I<LocalDatabase>().removeSchedule(scheduleWithColor.scheduleData.id);
                  },
                  child: GestureDetector(
                    onTap: () {

                      showModalBottomSheet(
                        // 하단부 팝업창 느낌 => showCupertinoDialog도 있지만 이걸 더 많이씀
                        context: context,
                        isScrollControlled: true,
                        // 이걸 설정해야 키보드 사이즈만큼 커져야할 때 커질수 있음=> default는 화면 반 이상 안되게 되어있음(모달은)
                        builder: (context) {
                          return NewScheduleBtnSheet(
                            selectedDate: selectedDate,
                            scheduleId: scheduleWithColor.scheduleData.id,
                          );
                        },
                      );

                    },
                    child: ScheduleCard(
                      startTime: scheduleWithColor.scheduleData.startTime,
                      endTime: scheduleWithColor.scheduleData.endTime,
                      content: scheduleWithColor.scheduleData.content,
                      color: Color(int.parse('FF$scheduleWithColor.categoryColor.hexCode', radix: 16)),
                    ),
                  ),
                );
              },
            );
          }
        ),
      ),
    );
  }
}
