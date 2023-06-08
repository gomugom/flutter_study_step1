import 'package:flutter/material.dart';
import 'package:study/screen/ColumnRow.dart';
import 'package:study/screen/page_view_test.dart';
import 'package:study/screen/Prac.dart';
import 'package:study/screen/StatefulWidget.dart';
import 'package:study/screen/WebviewPrac.dart';

void main() {
  runApp(
      // Widget - 클래스의 일종 : 화면에 나타나는 애들
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PageViewTest(),
  ));
}

// stateless widget
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.orange,
      backgroundColor: Color(0xFFF99231), // 0x : 16진수 처음 FF : 투명도(FF:사용x)
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            // .asset : asset에서 이미지 가져옴 / .network : network 통해서 가져옴
            'asset/img/logo.png',
          ),
          CircularProgressIndicator(
            color: Colors.white,
          ),
          HomeScreenTest()
        ],
      ),
    );
  }
}
