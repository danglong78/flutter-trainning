import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_retrofit_moor/data/local/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class ListItem extends StatelessWidget {
  final Dog dog;
  final VoidCallback onTap;

  const ListItem({
    Key? key,
    required this.dog,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.4;
    double width = MediaQuery.of(context).size.width * 0.85;
    return InkWell(
      onTap: onTap,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
            width: width,
            height: height,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: height / 4,
                  bottom: 0,
                  child: Hero(
                    tag: "background_${dog.name}",
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                              Theme.of(context).colorScheme.secondary,
                              Colors.white,
                            ],
                                stops: [
                              0.4,
                              1.0,
                            ])),
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          margin: const EdgeInsets.only(
                            left: 20,
                            bottom: 10,
                          ),
                          child: Text(
                            dog.name,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                    child: Hero(
                      tag: "image_${dog.name}",
                      child: dog.isFile
                          ? Image(
                              image: FileImage(File(dog.url)),
                              height: height / 1.2,
                              width: width * 0.98,
                              fit: BoxFit.fill,
                              filterQuality: FilterQuality.low,
                            )
                          : CachedNetworkImage(
                              imageUrl: dog.url,
                              progressIndicatorBuilder:
                                  (context, url, progress) =>
                                      LinearProgressIndicator(
                                value: progress.progress,
                              ),
                              errorWidget: (context, url, error) => Container(
                                  padding: EdgeInsets.fromLTRB(
                                      20.0, height / 3, 20.0, 30.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Icon(Icons.error),
                                      Text(
                                        error.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 15.0),
                                      )
                                    ],
                                  )),
                              height: height / 1.2,
                              width: width * 0.98,
                              fit: BoxFit.fill,
                            ),
                      // child: FutureBuilder<Uint8List>(future: _imageProcess(dog.url, dog.isFile),builder:(context, snapshot) {
                      //   if(snapshot.hasData){
                      //     return Image.memory(snapshot.data!,
                      //               height: height / 1.2,
                      //               width: width * 0.98,
                      //               fit: BoxFit.fill,
                      //     );
                      //   }
                      //   return Center(child:CircularProgressIndicator());
                      // } ,)
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
