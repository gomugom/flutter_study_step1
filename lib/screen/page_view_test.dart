import 'dart:async';

import 'package:flutter/material.dart';

class PageViewTest extends StatefulWidget {
  const PageViewTest({super.key});

  @override
  State<PageViewTest> createState() => _PageViewTestState();
}

class _PageViewTestState extends State<PageViewTest> {

  Timer? timer;
  PageController pageController = PageController(
    initialPage: 0
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int currentPage = pageController.page!.toInt();
      int nextPage = currentPage + 1;

      if(nextPage > 4) {

      }
      print('Timer!');
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    if(timer != null) timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [1,2,3,4,5].map((e) => Image.asset('asset/img/image_${e}.jpeg', fit: BoxFit.cover)).toList()
      ),
    );
  }
}
