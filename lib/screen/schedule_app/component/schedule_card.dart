import 'package:flutter/material.dart';
import 'package:study/screen/schedule_app/constant/color.dart';

class ScheduleCard extends StatelessWidget {
  final int startTime;
  final int endTime;
  final String content;
  final Color color;

  const ScheduleCard({
    required this.startTime,
    required this.endTime,
    required this.content,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: PRIMARY_SCHEDULE_COLOR,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: IntrinsicHeight( // 내부애들중 최대 height에 맞게 다른 애들도 높이를 맞춰줌(stretch의 높이를 제안함)
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Time(
                startTime: startTime,
                endTime: endTime,
              ),
              SizedBox(
                width: 16.0,
              ),
              _Content(content: content),
              SizedBox(
                width: 16.0,
              ),
              _Category(
                color: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Time extends StatelessWidget {
  final int startTime;
  final int endTime;

  const _Time({required this.startTime, required this.endTime, super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.w500,
      color: PRIMARY_SCHEDULE_COLOR,
      fontSize: 16.0,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${startTime.toString().padLeft(2, '0')}:00',
          style: textStyle,
        ),
        Text(
          '${endTime.toString().padLeft(2, '0')}:00',
          style: textStyle.copyWith(
            fontSize: 10.0,
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final String content;

  const _Content({required this.content, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(child: Text(content)));
  }
}

class _Category extends StatelessWidget {
  final Color color;

  const _Category({required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      width: 16.0,
      height: 16.0,
    );
  }
}
