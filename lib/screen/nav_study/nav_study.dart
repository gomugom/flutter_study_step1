import 'package:flutter/material.dart';
import 'package:study/layout/main_layout.dart';
import 'package:study/screen/nav_study/route_one_screen.dart';
import 'package:study/screen/nav_study/route_two_screen.dart';

class NavStudy extends StatelessWidget {
  const NavStudy({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope( // **** 안드로이드처럼 뒤로가기 버튼을 막아야할 경우 사용!!
      onWillPop: () async { // async만 가능
        // true - pop 가능
        // false - pop 불가능
        // 작업 진행
        final canPop = Navigator.of(context).canPop();

        return canPop;
      },
      child: MainLayout(
        title: 'Home Screen',
        children: [
          ElevatedButton(
            onPressed: () {
              // Navigator.of(context).pop(); // 최초에 pop하면 빈 검은화면이 됨(스택에 아무것도 없으니까)
              Navigator.of(context).maybePop(); // 뒤로갈 페이지가 없을경우 동작하지 않음
            },
            child: Text('May be Pop'),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigator.of(context).pop(); // 최초에 pop하면 빈 검은화면이 됨(스택에 아무것도 없으니까)
              Navigator.of(context).canPop(); // 뒤로갈 페이지가 있으면 true 없으면 false 리턴
              // maybePop은 canPop이 true일 경우만 동작하도록 구현되어 있음
            },
            child: Text('Can Pop'),
          ),
          // 1. 생성자를 통해 argument를 넘겨주는 방법
          ElevatedButton(
            onPressed: () async {
              // 바로 응답을 받는게 아니기 때문에 async로 되어야함
              final int result =
                  await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return RouteOneScreen(number: 109);
                },
              ));
            },
            child: Text('Push'),
          ),

          // 2. settings.arguments 를 통해 넘겨주는 방법
          ElevatedButton(
            // 스택 구조로 Route는 들어가게 됨
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return RouteTwoScreen();
                },
                settings: RouteSettings(arguments: 789),
              ));
            },
            child: Text('Push 2'),
          )
        ],
      ),
    );
  }
}
