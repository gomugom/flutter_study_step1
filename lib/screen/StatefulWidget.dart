import 'package:flutter/material.dart';

class StatefulWidgetTest extends StatefulWidget {

  final Color color;

  const StatefulWidgetTest({
    required this.color,
    super.key
  });

  @override
  State<StatefulWidgetTest> createState() => _StatefulWidgetTestState();

}

class _StatefulWidgetTestState extends State<StatefulWidgetTest> {

  int num = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            print('click!');
            setState(() {
              num++;
            });
          },
          child: Container(
            width: 50.0,
            height: 50.0,
            color: widget.color, // StatefulWidgetTest안에 있는 변수에 접근하는 키워드 : widget
            child: Text(num.toString()),
          ),
        ),
      ),
    );
  }


}
