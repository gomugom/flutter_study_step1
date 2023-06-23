import 'package:flutter/material.dart';
import 'package:study/screen/scrollable_widget/layout/main_layout.dart';
import 'package:study/screen/scrollable_widget/prac/study_scroll.dart';
import 'package:study/screen/scrollable_widget/scroll_components/custom_scroll_view_study.dart';
import 'package:study/screen/scrollable_widget/scroll_components/grid_view_study.dart';
import 'package:study/screen/scrollable_widget/scroll_components/list_view_study.dart';
import 'package:study/screen/scrollable_widget/scroll_components/refresh_indicator_study.dart';
import 'package:study/screen/scrollable_widget/scroll_components/reorderable_list_study.dart';
import 'package:study/screen/scrollable_widget/scroll_components/scroll_bar_study.dart';
import 'package:study/screen/scrollable_widget/scroll_components/single_child_scroll_view_screen.dart';

class ScreenModel {
  final WidgetBuilder builder;
  final String title;

  ScreenModel({required this.builder, required this.title});
}

class ScrollableWidget extends StatelessWidget {
  final screens = [
    ScreenModel(
      builder: (_) => SingleChildScrollViewScreen(),
      title: 'SingleChildScrollViewScreen',
    ),
    ScreenModel(
      builder: (_) => ListViewStudy(),
      title: 'ListViewScreen',
    ),
    ScreenModel(
      builder: (_) => GridViewStudy(),
      title: 'GridViewScreen',
    ),
    ScreenModel(
      builder: (_) => ReorderableListStudy(),
      title: 'ReorderableScrollViewScreen',
    ),
    ScreenModel(
      builder: (_) => CustomScrollViewStudy(),
      title: 'CustomScrollViewScreen',
    ),
    ScreenModel(
      builder: (_) => ScrollBarStudy(),
      title: 'ScrollBarScreen',
    ),
    ScreenModel(
      builder: (_) => RefreshIndicatorStudy(),
      title: 'RefreshIndicatorScreen',
    ),
    ScreenModel(
      builder: (_) => StudyScroll(),
      title: 'Practice',
    )
  ];

  ScrollableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Home',
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: screens.map((e) => ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: e.builder));
            }, child: Text(e.title))).toList(),
          ),
        ),
      ),
    );
  }
}
