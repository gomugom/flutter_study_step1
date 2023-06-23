import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study/screen/nav_study/nav_study.dart';
import 'package:study/screen/nav_study/route_one_screen.dart';
import 'package:study/screen/nav_study/route_three_screen.dart';
import 'package:study/screen/nav_study/route_two_screen.dart';

void main() {
  runApp(
    MaterialApp(
      // Named Route
      initialRoute: '/', // 최초 뜰 페이지
      routes: {
        '/' : (context) => NavStudy(),
        '/one' : (context) => RouteOneScreen(),
        '/two' : (context) => RouteTwoScreen(),
        '/three' : (context) => RouteThreeScreen()
      },
    )
  );
}