import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextStyleTest extends StatefulWidget {
  const TextStyleTest({super.key});

  @override
  State<TextStyleTest> createState() => _TextStyleTestState();
}

class _TextStyleTestState extends State<TextStyleTest> {

  DateTime selectedDate = DateTime(2021,10,30);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        bottom: false,
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Column(
            children: [
              _TopPart(
                  selectedDate: this.selectedDate,
                  onPressed: onHeartPressed,
              ),
              _BottomPart()
            ],
          ),
        ),
      ),
    );
  }

  void onHeartPressed() {

    DateTime now = DateTime.now();

    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            height: 300.0,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: selectedDate,
              maximumDate: DateTime(now.year,now.month,now.day),
              onDateTimeChanged: (value) {
                print(value);
                setState(() {
                  selectedDate = value;
                });
              },
            ),
          ),
        );
      },);
  }

}

class _TopPart extends StatelessWidget {

  final DateTime selectedDate;
  final VoidCallback onPressed;

  _TopPart({
    required this.selectedDate,
    required this.onPressed,
    Key? key
  }) : super(key:key);

  @override
  Widget build(BuildContext context) {

    final DateTime now = DateTime.now();

    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'U&I',
            style: textTheme.headline1,
          ),
          Column(
            children: [
              Text(
                '우리 처음 만난날',
                style: textTheme.bodyText1,
              ),
              Text(
                '${selectedDate.year}.${selectedDate.month}.${selectedDate.day}',
                style: textTheme.bodyText2,
              )
            ],
          ),
          IconButton(
            onPressed: this.onPressed,
            iconSize: 60.0,
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ),
          Text(
            'D+${
              DateTime(
                now.year,
                now.month,
                now.day
              ).difference(selectedDate).inDays + 1
            }',
            style: textTheme.headline2,
          ),
        ],
      ),
    );
  }
}

class _BottomPart extends StatelessWidget {
  const _BottomPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Image.asset(
        'asset/img/middle_image.png',
      ),
    );
  }
}
