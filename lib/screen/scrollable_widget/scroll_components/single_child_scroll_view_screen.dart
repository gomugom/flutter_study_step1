import 'package:flutter/material.dart';
import 'package:study/screen/scrollable_widget/constant.dart';
import 'package:study/screen/scrollable_widget/layout/main_layout.dart';

class SingleChildScrollViewScreen extends StatelessWidget {
  
  SingleChildScrollViewScreen({super.key});
  final List<int> numbers = List.generate(100, (index) => index);
  
  @override
  Widget build(BuildContext context) {
    
    const rainbowColors = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
    ];

    /*
    * SigleChildScrollView
    * : default는 스크롤 안되는대 사이즈를 넘어가면 스크롤되는 위젯.
    * */
    return MainLayout(
      title: 'SingleChildScrollView',
      body: renderPhysicsScroll(),
    );
  }

  // 1. 기본 렌더링법
  Widget renderSimple() {
    return SingleChildScrollView(
      child: Column(
        children: rainbowColors.map((e) => renderContainer(color: e)).toList(),
      ),
    );
  }

  // 2. 화면을 넘어가지 않아도 스크롤 되게하기
  Widget renderAlwaysScroll() {
    return SingleChildScrollView(
      // physics: NeverScrollableScrollPhysics(), // 이게 default
      physics: AlwaysScrollableScrollPhysics(), // 사이즈 안넘어가도 항상 스크롤되게 설정
      child: Column(
        children: rainbowColors.map((e) => renderContainer(color: e)).toList(),
      ),
    );
  }

  // 3. 화면 위젯이 잘리지 않게 하기
  Widget renderClipScroll() {
    return SingleChildScrollView(
      clipBehavior: Clip.none, // 스크롤해도 아랫부분 짤리지 않도록 설정
      physics: AlwaysScrollableScrollPhysics(), // 사이즈 안넘어가도 항상 스크롤되게 설정
      child: Column(
        children: rainbowColors.map((e) => renderContainer(color: e)).toList(),
      ),
    );
  }

  // 4. Physics별 스크롤 동작
  Widget renderPhysicsScroll() {
    return SingleChildScrollView(
      // physics: NeverScrollableScrollPhysics(), // 스크롤 안됨
      // physics: AlwaysScrollableScrollPhysics(), // 항상 스크롤 됨
      // physics: BouncingScrollPhysics(), // 튕기는듯한 스크롤(IOS 스타일)
      physics: ClampingScrollPhysics(), // Android 스타일 스크롤
      child: Column(
        children: rainbowColors.map((e) => renderContainer(color: e)).toList(),
      ),
    );
  }

  /*
  * ListView는 보이는 부분만 랜더링하고 안보이는 부분은 스크롤시 랜더링
  * ==> 5. SingleChildScrollView의 경우 한번에 모두 랜더링(멍청해!) => 성능적으로 고민을 좀 해보자!
  * */
  Widget renderChildPerformanceScroll() {
    return SingleChildScrollView(
      child: Column(
        children: numbers.map((e) => renderContainer(color: rainbowColors[e % rainbowColors.length])).toList(),
      ),
    );
  }

  Widget renderContainer({required Color color, int? index}) {

    if(index != null) {
      print(index);
    }

    return Container(
      height: 300,
      color: color,
    );
  }
}
