import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:demo_retrofit_moor/const.dart';
import 'package:demo_retrofit_moor/data/api/api_service.dart';
import 'package:demo_retrofit_moor/data/local/shared_preference.dart';
import 'package:demo_retrofit_moor/service/upload_service.dart';
import 'package:demo_retrofit_moor/widget/error_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:demo_retrofit_moor/data/local/uploads_dao.dart';

class UploadPage extends StatefulWidget {
  UploadPage({Key? key}) : super(key: key);

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final ImagePicker _picker = ImagePicker();
  File? file;
  List<File> images = [];

  final CarouselController _carouselController = CarouselController();
  late CarouselOptions _carouselOptions;

  @override
  void initState() {
    _carouselOptions = CarouselOptions(
      viewportFraction: 0.6,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 0.5;
    var width = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  child: file != null
                      ? Image.file(
                          file!,
                          fit: BoxFit.fill,
                        )
                      : Placeholder(),
                  height: height,
                  width: width),
              TextButton(
                  onPressed: () async {
                    final pickedFile = await _picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    var temp = File(pickedFile!.path);
                    setState(() {
                      file = temp;
                    });
                    await UploadService.instance
                        .uploadImage(temp)
                        .catchError((err) {
                      print(err);
                    });
                  },
                  child: Text("Upload File")),
              images.isEmpty
                  ? Placeholder()
                  : CarouselSlider.builder(
                      itemCount: images.length,
                      itemBuilder: (context, index, realIndex) {
                        return Image.file((images[index]));
                      },
                      options: _carouselOptions,
                    ),
              TextButton(
                  onPressed: () async {
                    final pickedList = await _picker.pickMultiImage();
                    if (pickedList != null) {
                      setState(() {
                        images.clear();
                        for (var item in pickedList) {
                          var temp = File(item.path);
                          images.add(temp);
                        }
                      });
                      UploadService.instance.stream.listen((event) {
                        print("Upload Page: Upload Sucess all File");
                      }, onError: (err) {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              ErrorDialog("Failed to upload ${err.length}"),
                        );
                      }, cancelOnError: false);
                      await UploadsDao.instance.insertUploads(images);
                      UploadService.instance.uploadImages(images);
                    }
                  },
                  child: Text("Upload Multiple File")),
            ],
          ),
        ),
      ),
    );
  }
}
