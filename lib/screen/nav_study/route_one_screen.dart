import 'package:flutter/material.dart';
import 'package:study/layout/main_layout.dart';

class RouteOneScreen extends StatelessWidget {
  final int? number;

  const RouteOneScreen({this.number, super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Route One',
      children: [
        Text(
          number.toString(),
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(456);
          },
          child: Text('뒤로가기(POP)'),
        )
      ],
    );
  }
}
