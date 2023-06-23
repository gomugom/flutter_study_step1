import 'package:flutter/material.dart';
import 'package:study/screen/scrollable_widget/constant.dart';
import 'package:study/screen/scrollable_widget/layout/main_layout.dart';

class ListViewStudy extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  ListViewStudy({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'ListViewStudy',
      body: renderBuilder(),
    );
  }

  // 1. default ListView
  // => 화면에 안보이는 부분까지도 한번에 실행됨(SingleChildScrollView처럼)
  Widget renderDefault() {
    return ListView(
      children: numbers
          .map((e) => renderContainer(
              color: rainbowColors[e % rainbowColors.length], index: e))
          .toList(),
    );
  }

  // 2. builder ListView
  // => 화면에 보이는 부분만 실행되고 스크롤시 보일 부분을 추가로 가져옴(화면에 보일 부분만 들고있음 : performance에 좋음)
  Widget renderBuilder() {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) {
        return renderContainer(color: rainbowColors[index % rainbowColors.length], index: index);
      },
    );
  }

  // 3. separated ListView
  // builder와 특징은 비슷한대 항목들 사이에 들어갈 부분을 지정할 수 있음
  // => 포스트 3개마다 광고(배너)를 넣거나 할 때 유용함
  Widget renderSeparated() {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return ((index % 3 == 0) ? renderContainer(color: Colors.black, index: index, height: 50) : Container());
      },
      itemCount: 100,
      itemBuilder: (context, index) {
        return renderContainer(color: rainbowColors[index % rainbowColors.length], index: index);
      },
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
