import 'dart:async';
import 'dart:io';

import 'package:demo_retrofit_moor/const.dart';
import 'package:demo_retrofit_moor/const.dart';
import 'package:demo_retrofit_moor/data/api/api_service.dart';
import 'package:demo_retrofit_moor/data/local/shared_preference.dart';

import 'package:demo_retrofit_moor/data/local/uploads_dao.dart';

class UploadService {
  static final instance = UploadService._internal();

  UploadService._internal();
  StreamController _resultStream = StreamController.broadcast();
  Stream get stream {

   return _resultStream.stream;
  }
  Future reUploadImage() async {
    var filePaths = await UploadsDao.instance.getPendingUploads();
    if (filePaths.isNotEmpty) {
      var files = filePaths.map((upload) => File(upload.path)).toList();
      return uploadImages(files);
    }
  }

  Future uploadImage(File image) async {
    try {
      await ApiService.instance.uploadImage(image);
      return image;
    } catch (err) {
      return Future.error(image);
    }
  }

  void uploadImages(List<File> images) {
    var listError = <File>[];
    uploadThreadPool.addAll(images);
    UploadsDao.instance.listenToUploads(uploadThreadPool.stream);
    try {
      uploadThreadPool.stream.listen(
          (data) {
            print("$data upload success");
          },
          onError: (err) {
            print("$err upload failed");
            listError.add(err);
          },
          cancelOnError: false,
          onDone: () {
            print("DONE DONE DONE !!!!!!");
            print("List File Error: ${listError.length}");
            print(listError);
            if (listError.isNotEmpty) {
              print("Retrying");
              try {
                _retryUpload(listError);
              } catch (err) {
                rethrow;
              }
            }
          });
    } catch (err) {
      rethrow;
    }
  }

  void _retryUpload(List<File> images) {
    uploadThreadPool.addAll(images);
    UploadsDao.instance.listenToUploads(uploadThreadPool.stream);
    List<File> failedFiles = [];
    uploadThreadPool.stream.listen(
        (data) {
          print("$data upload success");
        },
        onError: (err) {
          failedFiles.add(err);
          print("$err upload failed");
        },
        cancelOnError: false,
        onDone: () {
          print(" Retry Finished !!!!!!");
          if (failedFiles.isNotEmpty) {
            _resultStream.addError(failedFiles);
          }
          else{
          _resultStream.add("Success");}
        });
  }
}
