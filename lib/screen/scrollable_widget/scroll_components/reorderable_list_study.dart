import 'package:flutter/material.dart';
import 'package:study/screen/scrollable_widget/constant.dart';

class ReorderableListStudy extends StatefulWidget {
  const ReorderableListStudy({super.key});

  @override
  State<ReorderableListStudy> createState() => _ReorderableListStudyState();
}

// ** 위치를 바꿀 수 있는 스크롤뷰
class _ReorderableListStudyState extends State<ReorderableListStudy> {
  final List<int> numbers = List.generate(100, (index) => index);

  @override
  Widget build(BuildContext context) {
    return renderBuilder();
  }

  Widget renderBuilder() {
    return ReorderableListView.builder(
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[numbers[index] & rainbowColors.length],
          index: numbers[index],
        );
      },
      itemCount: numbers.length,
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = numbers.removeAt(oldIndex);
          numbers.insert(item, newIndex);
        });
      },
    );
  }

  Widget renderDefault() {
    return ReorderableListView(
      // 순서를 바꿀 수 있는 리스트 ===> 각 항목이 별개라는걸 알려주기 위해 key 필요!!
      children: numbers
          .map((e) => renderContainer(
              color: rainbowColors[e % rainbowColors.length], index: e))
          .toList(),
      onReorder: (oldIndex, newIndex) {
        // 화면에서만 바끼지 연결된 데이터는 우리가 바까야함
        // 순서 바꾸면 실행됨
        try {
          setState(() {
            // **** oldIndex와 newIndex 모두 이동이 되기 전에 산정한다.

            // [red, orange, yellow]
            // [0,     1,      2   ]

            // red를 yellow 다음으로 옮기고싶다.
            // red : 0 (oldIndex) -> 3 (newIndex) ==> newIndex는 옮기기 전에 배치를 기준으로하게 됨
            // [orange, yellow, red]

            // [red, orange, yellow]
            // yellow를 red 앞으로 옮기고싶다
            // yellow : 2(old) -> 0(newIndex) => 옮기고나서도 0이 맞음
            // [yellow, red, orange]

            // *** oldIndex < newIndex 인경우 옮긴index에서 1을 뺴줘야함, 반대는 정상이기 때문에 그대로

            if (oldIndex < newIndex) {
              newIndex -= 1;
            }

            final item = numbers.removeAt(oldIndex);
            numbers.insert(newIndex, item);
          });
        } catch (e, s) {
          print(s);
        }
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
