import 'package:flutter/material.dart';
import 'package:study/screen/scrollable_widget/constant.dart';

// 여러 스크롤뷰를 조합해서 사용할 수 있는 스크롤뷰
class CustomScrollViewStudy extends StatelessWidget {
  CustomScrollViewStudy({super.key});

  final List<int> numbers = List.generate(100, (index) => index);

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Column(
    //     children: [
    //       Expanded( // ListView와같이 끝없이 이어질 수 있는 위잿이 Colum, Row안에 올 때는
    //                 // 반드시 Expanded로 영역이 어디까진지 지정해주어야한다.!
    //         child: ListView(
    //           children: rainbowColors.map(
    //             (e) => renderContainer(color: e, index: 1),
    //           ).toList(),
    //         ),
    //       ),
    //       Expanded(
    //         child: GridView.count(
    //           crossAxisCount: 2,
    //           children: rainbowColors.map(
    //                 (e) => renderContainer(color: e, index: 1),
    //           ).toList(),
    //         ),
    //       )
    //     ],
    //   ),
    // );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          renderSliverAppBar(),
          renderHeader(),
          renderChildGridMaxCrossAxisExtentSliverList(),
          renderHeader(),
          renderChildBuilderSliverList(),
        ],
      ),
    );
  }

  Widget renderHeader() {
    return SliverPersistentHeader(
      pinned: true, // 내리다 나올때마다 위쪽에 minHeight만큼씩 계속 누적되어 쌓여감(true일 때)
      delegate: _SliverFixedHeaderDelegate(
        child: Container(
          color: Colors.black,
          child: Center(child: Text('Test')),
        ),
        maxHeight: 150,
        minHeight: 75,
      ),
    );
  }

  // 1. default SliverChildList
  Widget renderChildSliverList() {
    return SliverList(
      delegate: SliverChildListDelegate(// 한번에 모든 위잿이 그려지는 default
          numbers
              .map((e) => renderContainer(
                  color: rainbowColors[e % rainbowColors.length], index: e))
              .toList()),
    );
  }

  // 2. renderChildBuilderSliverList
  // 화면에 보이는것만 랜더링
  Widget renderChildBuilderSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        // 한번에 모든 위잿이 그려지는 default
        (context, index) {
          return renderContainer(
              color: rainbowColors[index % rainbowColors.length], index: index);
        },
        childCount: 100,
      ),
    );
  }

  // 3. 한번에 그리는 Grid => SliverChildListDelegate
  Widget renderChildGridSliverList() {
    return SliverGrid(
      delegate: SliverChildListDelegate(numbers
          .map((e) => renderContainer(
              color: rainbowColors[e % rainbowColors.length], index: e))
          .toList()),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 3.0,
      ),
    );
  }

  // 4. 보이는 부분만 먼저 그리는 Grid => SliverChildBuilderDelegate
  Widget renderChildGridBuilderSliverList() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        childCount: 100,
        (context, index) {
          return renderContainer(
              color: rainbowColors[index % rainbowColors.length], index: index);
        },
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 3.0,
        mainAxisSpacing: 3.0,
      ),
    );
  }

  // 5. 가로세로 차지할 수 있는 만큼씩 그리기
  Widget renderChildGridMaxCrossAxisExtentSliverList() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        childCount: 100,
        (context, index) {
          return renderContainer(
              color: rainbowColors[index % rainbowColors.length], index: index);
        },
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200, // 가로 200넓이로 배치할 수 있는만큼
      ),
    );
  }

  ////////////////////////////////////////

  // 6. SliverAppBar
  SliverAppBar renderSliverAppBar() {
    return SliverAppBar(
      floating: true,
      // 위로스크롤할 땐 appBar 나타남 // false면 맨위로 올라가야만 보임
      // scroll시 appBar까지 같이 스크롤되어버림
      // pinned: true, // 스크롤해도 appBar사라지지 않고 고정(완전 고정),
      snap: true,
      // 자석 효과, floating이 true인 경우만 가능
      stretch: true,
      // android는 원래 x, ios는 최대로 당기면 뒤에 scaffold가 안보이게 됨,
      // 맨 위에서 한계 이상으로 스크롤 했을 때 남는 공간을 처리
      expandedHeight: 200,
      // AppBar 높이 지정(기본)
      collapsedHeight: 150,
      // 말려올라갈 떄(접힐 때) 유지되는 높이
      flexibleSpace: FlexibleSpaceBar(
        // expandedHeight가 지정되어야 보임
        title: Text('FlexibleSpace'),
        background: Container(
          color: Colors.yellow,
        ),
      ),
      title: Text(
        'CustomScrollViewScreen',
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

// 지속적으로 쌓여가는 Header
class _SliverFixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  _SliverFixedHeaderDelegate({
    required this.child,
    required this.maxHeight,
    required this.minHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return SizedBox.expand(
      child: child,
    );
  }

  // 최대높이
  @override
  // TODO: implement maxExtent
  double get maxExtent => maxHeight;

  // 최소높이
  @override
  // TODO: implement minExtent
  double get minExtent => minHeight;

  @override
  // covariant - 상속된 클래스도 사용가능
  // 새로 빌드를 해야할지 말지를 결정
  bool shouldRebuild(_SliverFixedHeaderDelegate oldDelegate) {
    // oldDelegate - build가 실행이 됐을 때 이전 Delegate
    // this => 새로운 Delegate
    // child, maxHeiht, minHeight 중에 하나라도 바끼면 새로 변화되도록 해야함
    return oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.child != child;
  }
}