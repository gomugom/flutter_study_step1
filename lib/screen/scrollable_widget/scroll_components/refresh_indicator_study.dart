import 'package:flutter/material.dart';
import 'package:study/screen/scrollable_widget/constant.dart';

class RefreshIndicatorStudy extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);
  RefreshIndicatorStudy({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator( // 인스타 게시물 땡겨서 새로고침할 때, 위에 빙글빙글 로딩바 보여주기
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 3));
      },
      child: ListView(
        children: numbers.map((e) => renderContainer(color: rainbowColors[e % rainbowColors.length], index: e)).toList(),
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
