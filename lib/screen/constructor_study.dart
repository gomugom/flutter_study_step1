import 'package:flutter/material.dart';

class ConstructorStudy extends StatefulWidget {
  const ConstructorStudy({super.key});

  @override
  State<ConstructorStudy> createState() => _ConstructorStudyState();
}

class _ConstructorStudyState extends State<ConstructorStudy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const로 선언한 위젯은 처음에만 그리고 그 이후부터는 다시 그려지지 않고 초기상태를 그대로 사용함
            const TestWidget(label: 'test1'),
            TestWidget(label: 'test2'),
            ElevatedButton(
              onPressed: () {
                setState(() {

                });
              },
              child: const Text('빌드'),
            )
          ],
        ),
      ),
    );
  }
}

class TestWidget extends StatelessWidget {
  final String label;

  const TestWidget({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    print('${this.label} 빌드 실행');
    return Container(
      child: Text(this.label),
    );
  }
}
