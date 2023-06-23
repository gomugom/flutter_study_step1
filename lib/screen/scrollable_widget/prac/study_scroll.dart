import 'package:flutter/material.dart';
import 'package:study/screen/scrollable_widget/constant.dart';

class StudyScroll extends StatefulWidget {
  StudyScroll({super.key});

  @override
  State<StudyScroll> createState() => _StudyScrollState();
}

class _StudyScrollState extends State<StudyScroll> {
  final List<int> numbers = List.generate(50, (index) => index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            // setState를 통해 데이터 재세팅
            await Future.delayed(
              Duration(seconds: 2),
            );
          },
          child: Scrollbar(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text('Sliver App Bar'),
                  // pinned: true,
                  floating: true, // 내릴땐 사라지고 올릴땐 다시 나옴(true), false는 올릴떄도 안나옴
                  actions: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.home)),
                  ],
                  expandedHeight: 150,
                  flexibleSpace: Container(color: Colors.green,),
                ),
                SliverPersistentHeader(delegate: _SliverPersistenceHeader(
                    maxLength: 120,
                    minLength: 120,
                  ),
                  pinned: true,
                  floating: true,
                ),
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return renderContainer(color: rainbowColors[index], index: index);
                    },
                    childCount: 5
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                ),
                SliverPersistentHeader(delegate: _SliverPersistenceHeader(
                  maxLength: 120,
                  minLength: 120,
                ), pinned: true, floating: true,),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return renderContainer(
                        color: rainbowColors[index], index: index);
                  }, childCount: rainbowColors.length),
                )
              ],
            ),
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

class _SliverPersistenceHeader extends SliverPersistentHeaderDelegate {

  final double maxLength;
  final double minLength;

  _SliverPersistenceHeader({required this.maxLength, required this.minLength});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Container(color: Colors.black,height: maxLength,);
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => maxLength;

  @override
  // TODO: implement minExtent
  double get minExtent => minLength;

  @override
  bool shouldRebuild(_SliverPersistenceHeader oldDelegate) {
    // TODO: implement shouldRebuild
    if(oldDelegate.minLength != minLength || oldDelegate.maxLength != maxLength) {
      return true;
    } else {
      return false;
    }
  }

}