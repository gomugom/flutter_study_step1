import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PageViewPrac1 extends StatefulWidget {
  const PageViewPrac1({super.key});

  @override
  State<PageViewPrac1> createState() => _PageViewPrac1State();
}

class _PageViewPrac1State extends State<PageViewPrac1> {

  PageController? pageController = new PageController(initialPage: 0);

  Timer? timer;

  int nextPage = 0;

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if(pageController != null) {
        int currentPage = pageController!.page!.toInt();

        nextPage = currentPage + 1;

        if(nextPage > 4) nextPage = 0;

        pageController!.animateToPage(nextPage, duration: Duration(milliseconds: 400), curve: Curves.linear);
      }
    });
    super.initState();
  }

  @override
  void dispose() {

    if(pageController != null) pageController!.dispose();

    if(timer != null) timer!.cancel();

    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: pageController,

          children: ['1','2','3','4','5'].map((e) => Image.asset('asset/img/image_${e}.jpeg', fit: BoxFit.cover,)).toList()
        ),
      ),
    );
  }
}
