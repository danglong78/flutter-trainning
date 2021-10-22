import 'dart:async';

import 'package:better_player/better_player.dart';
import 'package:demo_retrofit_moor/model/video_model.dart';
import 'package:demo_retrofit_moor/page/list_videos/preview_video_player.dart';
import 'package:demo_retrofit_moor/page/video_detail/detail_video_page.dart';
import 'package:flutter/material.dart';

class VideoCard extends StatefulWidget {
  const VideoCard({Key? key, required this.video}) : super(key: key);
  final VideoModel video;
  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  bool isPreview = false;

  @override
  void activate() {
    print("activate");
    super.activate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
      child: GestureDetector(
        onLongPressStart: (details) {
          print("Press down");
          setState(() {
            isPreview = true;
          });
        },
        onLongPressEnd: (details) {
          print("Press ip");

          setState(() {
            isPreview = false;
          });
        },
        onTap: () {
          print("Tap");

          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return DetailVideoPage(video: widget.video);
            },
          ));
        },
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
            child: Column(
              children: [
                AspectRatio(
                    aspectRatio: 16 / 9,
                    child: isPreview
                        ? PreviewVideoPlayer(videoUrl: widget.video.videoUrl)
                        : Image.network(
                            widget.video.imgUrl,
                            fit: BoxFit.contain,
                          )),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                          child: Text(
                        widget.video.title,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline6,
                      )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
