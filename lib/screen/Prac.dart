import 'package:flutter/material.dart';

class Prac extends StatelessWidget {
  const Prac({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                )
              ],
            ),
            Container(
              color: Colors.orange,
              width: 50.0,
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
                )
              ],
            ),
            Container(
              color: Colors.green,
              width: 50.0,
              height: 50.0,
            )
          ],
        ),
      ),
    );
  }
}
