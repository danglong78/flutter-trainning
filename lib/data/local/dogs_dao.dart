import 'dart:io';

import 'package:demo_retrofit_moor/data/local/database.dart';
import 'package:demo_retrofit_moor/model/dog_model.dart';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

part 'dogs_dao.g.dart';

@DriftAccessor(tables: [Dogs])
class DogsDao extends DatabaseAccessor<MyDatabase> with _$DogsDaoMixin{
  static final instance = DogsDao._internal(MyDatabase.instance);

  DogsDao._internal(MyDatabase db) : super(db);

  Future<void> insertMultiDogs(List<DogModel> listDogs) async {
    for (var dog in listDogs) {
      if (dog.isFile) {
        var bytes = await rootBundle.load(dog.url);
        var fileSize = (bytes.buffer.lengthInBytes / (1024 * 1024));
        if (fileSize > 5) {
          String tempPath = (await getTemporaryDirectory()).path;
          File file = File('$tempPath/${DateTime.now()}.jpg');
          var result = await FlutterImageCompress.compressWithList(
            bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes),
            quality: 10,
          );
          await file.writeAsBytes(result);
          dog.url = file.absolute.path;
        }
      } else {
        final response = await http.get(Uri.parse(dog.url));
        var fileSize = (response.bodyBytes.lengthInBytes / (1024 * 1024));
        if (fileSize > 5) {
          String tempPath = (await getTemporaryDirectory()).path;
          File file = File('$tempPath/${DateTime.now().toIso8601String()}.jpg');
          var result = await FlutterImageCompress.compressWithList(
            response.bodyBytes,
            quality: 10,
          );
          await file.writeAsBytes(result);
          dog.isFile = true;
          dog.url = file.absolute.path;
        }
      }
    }
    await batch((batch) {
      batch.insertAll(dogs, [
        for (var entry in listDogs)
          DogsCompanion.insert(
              breed: entry.breed,
              name: entry.name,
              url: entry.url,
              isFile: entry.isFile,
              describe: entry.describe)
      ]);
    });
  }

  Future<List<Dog>> get allDogs => select(dogs).get();
  Stream<List<Dog>> watchEntriesInDog() => select(dogs).watch();

  Future deleteAll() {
    return (delete(dogs)).go();
  }

  Future<List<Dog>> getDogs(int index, int limit) {
    return (select(dogs)..limit(limit, offset: index)).get();
  }

}