import 'package:flutter/material.dart';

class ButtonStudy extends StatelessWidget {
  const ButtonStudy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('버튼 study'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                // 3D로 튀어나온 느낌의 버튼
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  // 메인 칼라
                  primary: Colors.red,
                  // 글자 애니메이션 색깔
                  onPrimary: Colors.black,
                  // 그림자 색깔
                  shadowColor: Colors.green,
                  // 튀어나온 정도(3D 입체감의 높이)
                  elevation: 10.0,
                  textStyle: TextStyle(fontWeight: FontWeight.bold),
                  padding: EdgeInsets.all(8.0),
                  side: BorderSide(
                    color: Colors.black,
                    width: 4.0, // 너비(테두리 두께)
                  ),
                ),
                child: Text('ElevatedButton'),
              ),
              ElevatedButton.icon(
                // Icon이 들어가는 Elevated Button
                onPressed: () {},
                icon: Icon(Icons.refresh),
                label: Text('icon Elevated Btn'),
              ),
              OutlinedButton(
                // 외곽선만 있는 버튼
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                    primary: Colors.green,
                    foregroundColor: Colors.green, // 위에꺼 대신 권장하고 있음
                    backgroundColor:
                        Colors.yellow // 배경색 => 배경색을 바꾸면 ElevatedButton 처럼 됨
                    ),
                child: Text('OutlinedButton'),
              ),
              TextButton(
                // 글자만 있는 버튼
                onPressed: () {},
                style: TextButton.styleFrom(primary: Colors.blue),
                child: Text('TextButton'),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.home),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  // Material State
                  //
                  // hovered - 호버링 상태 (마우스 커서를 올려놓은 상태) : 모바일엔 불가능
                  // focused - 포커스 됐을 때 (텍스트 필드)
                  // pressed - 눌렸을 때
                  // dragged - 드래그 됐을 때
                  // selected - 선택됐을 때 (체크박스, 라디오 버튼)
                  // scrollUnder - 다른 컴포넌트 밑으로 스크롤링 됐을 때
                  // disabled - 비활성화 됐을 때 // onPressed를 null로하면 비활성화 됨
                  // error - 에러상태
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  // 한번에 다 적용
                  foregroundColor:
                      MaterialStateProperty.resolveWith(// Event조건별 상태
                          (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.white;
                    }
                    return Colors.red;
                  }),
                  padding: MaterialStateProperty.resolveWith((states) {
                    if(states.contains(MaterialState.pressed)) {
                      return EdgeInsets.all(10.0);
                    }
                    return EdgeInsets.all(20.0);
                  },)
                ),
                child: Text('ButtonStyle'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
