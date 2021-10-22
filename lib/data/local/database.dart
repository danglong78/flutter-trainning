
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'dart:io';

part 'database.g.dart';

class Dogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().named('name')();
  TextColumn get url => text().named('url')();
  BoolColumn get isFile => boolean().named('isFile')();
  TextColumn get breed => text().named('breed')();
  TextColumn get describe => text().named('describe')();
}
class Uploads extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get status => text().named('status ')();
  TextColumn get path => text().named('path')();
}
@DriftDatabase(tables: [Dogs,Uploads])
class MyDatabase extends _$MyDatabase {
  static final instance = MyDatabase._internal();

  MyDatabase._internal()
      : super(_openConnection());

  @override
  int get schemaVersion => 1;


}
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}