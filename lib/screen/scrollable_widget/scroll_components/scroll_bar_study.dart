import 'package:flutter/material.dart';
import 'package:study/screen/scrollable_widget/constant.dart';
import 'package:study/screen/scrollable_widget/layout/main_layout.dart';

class ScrollBarStudy extends StatelessWidget {

  final List<int> numbers = List.generate(100, (index) => index);
  ScrollBarStudy({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'ScrollbarScreen',
      body: Scrollbar( // Scrollbar 위잿 사용하면 됨
        child: SingleChildScrollView(
          child: Column(
            children: numbers.map((e) => renderContainer(color: rainbowColors[e % rainbowColors.length], index: e)).toList(),
          ),
        ),
      ),
    );
  }

  Widget renderContainer({
    required Color color,
    required int index,
    double? height,
  }) {
    if (index != null) {
      print(index);
    }

    return Container(
      key: Key(index.toString()), // 구분되는 값(list에서)
      height: height ?? 300, // height가 null이면 300 아니면 height 값
      color: color,
      child: Center(
        child: Text(
          index.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }

}
