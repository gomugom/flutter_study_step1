import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:study/prac/page_view_prac.dart';
import 'package:study/screen/ColumnRow.dart';
import 'package:study/screen/google_map/google_map_study.dart';
import 'package:study/screen/schedule_app/database/drift_database.dart';
import 'package:study/screen/schedule_app/schedule_app.dart';
import 'package:study/screen/scrollable_widget/scrollable_widget.dart';
import 'package:study/screen/vide_player/video_player.dart';

// intl 사용을위해 불러와야하는 구문 => main에서 초기화하자
import 'package:intl/date_symbol_data_local.dart';

const DEFAULT_COLORS = [
  // 빨강
  'F44336',
  // 주황
  'FF9800',
  //노랑
  'FFEB3B',
  //초록
  'FCAF50',
  //파랑
  '2196F3',
  //남
  '3F51B5'
];

void main() async {

  // runApp을 부르기 전에 호출하려면 플러터 프레임워크가 준비가 된 상태인지 확인이 필요함
  // => ensureInitialized 메서드 => 본래 runApp에서 호출함
  WidgetsFlutterBinding.ensureInitialized();

  // await initializeDateFormatting();

  // drift 통해 DB객체 가져오기 => ensureInitialized 호출 필요
  final database = LocalDatabase();

  // Provider라 생각하면 됨 => 다른 컴포넌트에서 가져올 수 있게 됨
  GetIt.I.registerSingleton<LocalDatabase>(database);

  final colors = await database.getCategoryColors();

  if(colors.isEmpty) {
    for(String hexCode in DEFAULT_COLORS) {
      await database.createCategoryColor(CategoryColorsCompanion(
        // id는 넣어줄 필요 없이 autoIncrement
        hexCode: Value(hexCode)
      ));
    }
  }

  runApp(
      // Widget - 클래스의 일종 : 화면에 나타나는 애들
      MaterialApp(
        theme: ThemeData(
          fontFamily: 'notosans',
          // textTheme: TextTheme(
          //   headline1: TextStyle(
          //     fontFamily: 'parisienne',
          //       color: Colors.white,
          //       fontSize: 80.0,
          //       fontWeight: FontWeight.w700
          //   ),
          //   headline2: TextStyle(
          //     color: Colors.white,
          //     fontSize: 50.0,
          //     fontWeight: FontWeight.w500,
          //   ),
          //   bodyText1: TextStyle(
          //       color: Colors.white,
          //       fontSize: 20.0
          //   ),
          //   bodyText2: TextStyle(
          //       color: Colors.white,
          //       fontSize: 30
          //   )
          // )
        ),
        debugShowCheckedModeBanner: false,
        home: ScrollableWidget(),
  ));
}
