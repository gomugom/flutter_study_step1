import 'package:drift/drift.dart';

// 이렇게 drift를 이용해 구성하면 이 테이블을 자동으로 생성해줌
class Schedule extends Table { // Table => drift(ORM)

  // PK
  IntColumn get id => integer().autoIncrement()(); // 자동증가

  // 내용
  TextColumn get content => text()();

  // 일정 날짜
  DateTimeColumn get date => dateTime()();

  // 시작 시간
  IntColumn get startTime => integer()();

  // 끝 시간
  IntColumn get endTime => integer()();

  // Category Color Table ID
  IntColumn get colorId => integer()();

  // 생성날짜 => 현재날짜를 가져오면 됨
    // default값으로 현재날짜 DateTime객체를 넣어줌
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();

}