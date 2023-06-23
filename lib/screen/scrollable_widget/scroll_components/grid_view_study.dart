import 'package:flutter/material.dart';
import 'package:study/screen/scrollable_widget/constant.dart';
import 'package:study/screen/scrollable_widget/layout/main_layout.dart';

class GridViewStudy extends StatelessWidget {
  List<int> numbers = List.generate(100, (index) => index);

  GridViewStudy({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'GridViewScreen',
      body: renderGridMaxExtent(),
    );
  }

  // 1. GridView Count
  // => 한번에 다 그림
  Widget renderGridCount() {
    return GridView.count(
      crossAxisCount: 2, // GridView 기본방향이 수직이라 cross면 가로개수
      crossAxisSpacing: 12.0, // 가로 간격
      mainAxisSpacing: 12.0, // 세로 간격
      children: numbers
          .map(
            (e) =>
            renderContainer(
              color: rainbowColors[e % rainbowColors.length],
              index: e,
            ),
      )
          .toList(),
    );
  }

  // 2. GridView Builder
  // => SliverGridDelegateWithFixedCrossAxisCount : 배치할 개수를 제안함
  // => 보이는 부분만 그림(성능 Good)
  Widget renderGridBuilder() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
      ),
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length], index: index,
        );
      },
      itemCount: 100,
    );
  }

  // 3. GridView Builder max Extent
  // => 보이는 부분만 그림
  // 위젯 하나하나 차지할 최대 길이를 지정해서 배치
  Widget renderGridMaxExtent() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200, // 하나 하나 들어가는 위젯들의 최대길이 (200을 넘지 않는 선에서 배치할 수 있는 최대치를 찾음)
      ),
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length], index: index,
        );
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
