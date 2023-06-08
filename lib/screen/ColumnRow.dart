import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreenTest extends StatelessWidget {
  const HomeScreenTest({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false, // bottom부분은 적용하지 않음(IOS에서 풀스크린 느낌위함)
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          // MainAxisAlignment - 주축 정렬
          // start - 시작
          // end - 끝
          // center - 가운데
          // spaceBetween - 위젯과 위젯의 사이가 동일하게 배치된다.
          // spaceEvenly - 위젯을 같은 간격으로 배치하지만 끝과 끝에도 위젯이 아닌 빈 간격으로 시작한다.
          // spaceAround - spaceEvenly + 끝과 끝의 간격은 1/2
          
          // CrossAxisAlignment - 반대측 정렬 -> ROW이면 세로, Column이면 가로
          // stretch : 가로로 꽉 채워버림
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max, // MainAxisSize - 주축 크기 max : 최대, min : 최소
          children: [
            Container(
              color: Colors.red,
              width: 50.0,
              height: 50.0,
            ),
            Container(
              color: Colors.orange,
              width: 50.0,
              height: 50.0,
            ),
            Container(
              color: Colors.yellow,
              width: 50.0,
              height: 50.0,
            ),
            Container(
              color: Colors.green,
              width: 50.0,
              height: 50.0,
              child: Column(
                // Expanded / Flexible은 Column이나 Row내에서만 사용 가능
                children: [
                  Expanded( // Expanded => 나머지 공간을 가득 채워버림
                    flex: 1, // 나머지 공간을 나눠먹는 비율(Expanded끼리 지정할 수 있음)
                    child: Container(
                      color: Colors.black38,
                      width: 20.0,
                      height: 20.0,
                    ),
                  ),
                  Flexible( // 전체 크기는 유지하되 child에 지정한 크기만큼 차지하고 나머진 아래에 차지하게 됨
                    child: Container(
                      color: Colors.black38,
                      width: 20.0,
                      height: 20.0,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

