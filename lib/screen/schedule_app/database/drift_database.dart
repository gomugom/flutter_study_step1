// import는 private 값들은 불러올 수 없다.
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:study/screen/schedule_app/model/category_color.dart';
import 'package:study/screen/schedule_app/model/schedule.dart';

import 'package:path/path.dart' as p;
import 'package:study/screen/schedule_app/model/schedule_with_color.dart';

// private 값까지 불러올 수 있다. => 같은 파일인 것 마냥 인식하게 됨
part 'drift_database.g.dart'; // 명령어에 의해 이 파일이 생기게 됨

@DriftDatabase(tables: [Schedule, CategoryColors]) // 사용할 테이블 알려주는 것
class LocalDatabase extends _$LocalDatabase { // _$LocalDatabase는 part 부분에 선언한 파일 안에 있음
  // _ => private 임에도 불러올 수 있는건 part로 가져왔기 때문
  LocalDatabase() : super(_openConnection());

  // VO + Companion으로 넣어줘야 insert가 동작하게 됨
  Future<int> createSchedule(ScheduleCompanion data) => into(schedule).insert(data);

  Future<int> createCategoryColor(CategoryColorsCompanion data) => into(categoryColors).insert(data);

  Future<List<CategoryColor>> getCategoryColors() => select(categoryColors).get();

  // .get() => 단발성으로 Future로 한번 값을 받음
  // .watch() => Stream으로 지속적으로 감시해서 데이터를 받음
  // Stream<List<ScheduleData>> watchSchedules(DateTime date) =>
  // // .. 문법 => 그 결과가 리턴되는게 아니라 결과를 반영하게된 대상이 리턴됨
  //     // 아래의 경우 ..where하면 where의 결과가 리턴되는게 아니라 where가 실행되고 난 후의 select의 결과가 리턴됨
  //     // watch가 select의 결과에 호출하는 함수기 때문에 이런식으로 함
  //   (select(schedule)..where((tbl) => tbl.date.equals(date))).watch();

  Stream<List<ScheduleWithColor>> watchSchedules(DateTime date) {

    final query = select(schedule).join([ // equals말고 eqaualsExp 써야함
      innerJoin(categoryColors, categoryColors.id.equalsExp(schedule.colorId))
    ]);

    // join이라 테이블을 정확히 지정해 주어야함
    query.where(schedule.date.equals(date));
    query.orderBy([
      OrderingTerm.asc(schedule.startTime),
    ]);

    return query.watch().map((rows) =>
      rows.map((row) => ScheduleWithColor(
          scheduleData: row.readTable(schedule) ,
          categoryColor: row.readTable(categoryColors))
      ).toList()
    );
    
  }

  // 반환형은 삭제한 id
  Future<int> removeSchedule(int id) => (delete(schedule)..where((tbl) => schedule.id.equals(id))).go();

  Future<int> updateScheduleById(int id, ScheduleCompanion data) => (update(schedule)..where((tbl) => tbl.id.equals(id))).write(data);

  Future<ScheduleData> selectScheduleById(int id) => (select(schedule)..where((tbl) => tbl.id.equals(id))).getSingle();

  @override
  // TODO: implement schemaVersion
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {

  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase(file);
  },);

}