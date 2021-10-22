import 'dart:async';
import 'dart:io';

import 'package:demo_retrofit_moor/data/local/database.dart';
import 'package:drift/drift.dart';

part 'uploads_dao.g.dart';

@DriftAccessor(tables: [Uploads])
class UploadsDao extends DatabaseAccessor<MyDatabase> with _$UploadsDaoMixin {
  static final instance = UploadsDao._internal(MyDatabase.instance);

  UploadsDao._internal(MyDatabase db) : super(db);

  Future updateStatus(String file, String status) {
    return (update(uploads)..where((upload) => upload.path.equals(file)))
        .write(UploadsCompanion(status: Value(status)));
  }

  Future insertUploads(List<File> files) async {
    await batch((batch) {
      batch.insertAll(uploads, [
        for (var entry in files)
          UploadsCompanion.insert(status: "Pending", path: entry.absolute.path)
      ]);
    });
  }

  Future<List<Upload>> getPendingUploads()
  {
    return (select(uploads)..where((upload) => upload.status.like("Pending"))).get();
  }
  Future getFailedUploads()
  {
    return (select(uploads)..where((upload) => upload.status.like("Failed"))).get();
  }


  void listenToUploads(Stream uploadStream) {
    uploadStream.listen((value) {
      updateStatus(value.absolute.path, "Success").then((_) =>print("$value status success")
      );
    }, onError: (value) {
      updateStatus(value.absolute.path, "Failed").then((_) =>print("$value status failed"));
    }, cancelOnError: false);
  }
}
