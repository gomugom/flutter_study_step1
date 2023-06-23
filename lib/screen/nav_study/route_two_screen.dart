import 'package:flutter/material.dart';
import 'package:study/layout/main_layout.dart';
import 'package:study/screen/nav_study/route_three_screen.dart';

class RouteTwoScreen extends StatelessWidget {
  const RouteTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;

    return MainLayout(title: 'Route Two', children: [
      Text(
        'arguments : ${arguments}',
        textAlign: TextAlign.center,
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('뒤로가기(POP)'),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/three', arguments: 999);
        },
        child: Text('Push Named'),
      ),
      ElevatedButton(
        // Replace Push => 스택에서 현재 route를 대체해버림(replace named도 마찬가지)
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) {
              return RouteThreeScreen();
            },
          ));
        },
        child: Text('Replace Push'),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (context) {
              return RouteThreeScreen();
            },
          ),
              (route) =>
                  route.settings.name ==
                  '/'); // /인 경우만 살리고 지움 즉, 뒤로가기 등을 누르면 홈으로 가짐
        }, // true리턴시 살리고 false리턴시 스택에서 지움
        child: Text('Push And Remove Until'),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamedAndRemoveUntil('/three', (route) => route.settings.name == '/');
        },
        child: Text('Push And Remove Until Named'),
      )
    ]);
  }
}
