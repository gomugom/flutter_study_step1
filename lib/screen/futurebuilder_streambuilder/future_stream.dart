import 'dart:math';

import 'package:flutter/material.dart';

class FutureStream extends StatefulWidget {
  const FutureStream({super.key});

  @override
  State<FutureStream> createState() => _FutureStreamState();
}

class _FutureStreamState extends State<FutureStream> {
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 16.0,
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<int>(
          future: getNumber(),
          builder: (context, snapshot) {

            // 처음만 데이터없고 그 이후 setState등에 의해 재실행될 때는 캐싱되어 있음
            // connectionState가 waiting일 때 circular를 보여주면 너무 앱이 느려보임
            // 캐싱이 굉장한 강점임! => 불러오는 동안도 사용할 수 있는 것 같은 느낌을 줌
            if(!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            if(snapshot.hasData) {
              // 데이터가 있을 때 위젯 랜더링
            }
            
            if(snapshot.hasError) {
              // 에러가 났을 때 위젯 랜더링
            }
            
            // 로딩중일 때 위젯 랜더링
            
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'FutureBuilder',
                  style: textStyle.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0
                  ),
                ),
                Text( // ConnectionState. none/waiting/done
                  'ConState : ${snapshot.connectionState}',
                  style: textStyle,
                ),
                Text(
                    'Data : ${snapshot.data}'
                ),
                Text(
                    'Error : ${snapshot.error}'
                ),
                ElevatedButton(onPressed: () {
                  setState(() {

                  });
                }, child: Text('setState'))
              ],
            );
          },
        ),
      ),
    );
  }

  Future<int> getNumber() async {
    await Future.delayed(Duration(seconds: 3));

    final random = Random();
    return random.nextInt(100);
  }

  // connectionState. none / waiting:active되기까지 전 상태 / active : 값 받는동안의 상태 / done
  Stream<int> streamNumbers() async* {

    for(int i = 0; i < 10; i++) {
      await Future.delayed(Duration(seconds: 1));
      yield i;
    }

  }


}
