import 'package:flutter/material.dart';
import 'package:study/component/number_row.dart';
import 'package:study/constant/color.dart';

class SettingsNav extends StatefulWidget {

  final int maxNumber;
  const SettingsNav({required this.maxNumber, super.key});

  @override
  State<SettingsNav> createState() => _SettingsNavState();
}

class _SettingsNavState extends State<SettingsNav> {

  double maxNumber = 10000; // 여기에 바로 widget.maxNumber하면 안됨
                            // 이곳에 선언된 변수는 SettingsNav에 붙기전에 실행되기 때문 따라서 initState에서 접근해야함

  @override
  void initState() {
    super.initState();
    maxNumber = widget.maxNumber.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PRIMARY_COLOR,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Body(
                  maxNumber: maxNumber,
                ),
                _Footer(
                  maxNumber: maxNumber,
                  onSliderChanged: onSliderChanged,
                  onButtonPressed: onButtonPressed,
                )
              ],
            ),
          ),
        ));
  }

  void onSliderChanged(value) {
    setState(() {
      maxNumber = value;
    });
  }

  void onButtonPressed() {
    Navigator.of(context).pop(maxNumber.toInt()); // 뒤로가기
  }

}

class _Body extends StatelessWidget {
  final double maxNumber;
  const _Body({required this.maxNumber, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NumberRow(
        number: maxNumber.toInt(),
      ),
    );
  }
}

class _Footer extends StatelessWidget {

  final ValueChanged<double>? onSliderChanged;
  final VoidCallback onButtonPressed;

  final double maxNumber;
  const _Footer({required this.onButtonPressed, required this.onSliderChanged, required this.maxNumber, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Slider(
          value: maxNumber,
          min: 1000,
          max: 100000,
          autofocus: true,
          onChanged: onSliderChanged,
        ),
        ElevatedButton(
          onPressed: onButtonPressed,
          style: ElevatedButton.styleFrom(
              primary: RED_COLOR
          ),
          child: Text('저장!'),
        )
      ],
    );
  }
}
