import 'dart:math';

import 'package:flutter/material.dart';
import 'package:study/component/number_row.dart';
import 'package:study/constant/color.dart';
import 'package:study/screen/random_num_game/settings_nav.dart';

class RandomNumGame extends StatefulWidget {
  const RandomNumGame({super.key});

  @override
  State<RandomNumGame> createState() => _RandomNumGameState();
}

class _RandomNumGameState extends State<RandomNumGame> {
  int maxNumber = 1000;

  // 변화되는 데이터는 최상단 부모에서 관리하는게 좋음
  List<int> randomNumber = [123, 456, 789];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(
                onPressed: onSettingsPop,
              ),
              _Body(
                randomNumber: randomNumber,
              ),
              _Footer(
                onPressed: onRandomNumberGenerate,
              )
            ],
          ),
        ),
      ),
    );
  }

  void onSettingsPop() async {
    final int? result = await Navigator.of(context).push<int>(MaterialPageRoute(
      builder: (context) {
        return SettingsNav(
          maxNumber: maxNumber,
        );
      },
    ));

    if (result != null) {
      setState(() {
        maxNumber = result;
      });
    }
  }

  void onRandomNumberGenerate() {
    final rand = Random();

    // Set => 중복숫자 불가(중복숫자 발생시 무시함 add하지 않음)
    final Set<int> newNumbers = {};

    while (newNumbers.length != 3) {
      final number = rand.nextInt(maxNumber);
      newNumbers.add(number);
    }

    setState(() {
      randomNumber = newNumbers.toList();
    });
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onPressed;

  const _Header({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '랜덤숫자 생성기',
          style: TextStyle(
              color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.w700),
        ),
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.settings,
            color: RED_COLOR,
          ),
        )
      ],
    );
  }
}

class _Body extends StatelessWidget {
  List<int> randomNumber;

  _Body({required this.randomNumber, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
            // asMap().entries 하면 key : value 배열로 리턴
            mainAxisAlignment: MainAxisAlignment.center,
            children: randomNumber
                .asMap()
                .entries
                .map((x) => Padding(
                      padding: EdgeInsets.only(bottom: x.key == 2 ? 0 : 16.0),
                      child: NumberRow(number: x.value.toInt()),
                    ))
                .toList()));
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onPressed;

  const _Footer({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Container보다 단순기능(간단기능은 이게 더 성능이 좋음), 성능뿐 아니라 네이밍도 기능을 알 수 있음
      width: double.infinity, // 꽉 채우기 위해 무한대값으로 넣어줌
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: RED_COLOR,
        ),
        onPressed: this.onPressed,
        child: Text('생성하기'),
      ),
    );
  }
}
