import 'package:better_player/better_player.dart';
import 'package:demo_retrofit_moor/model/video_model.dart';
import 'package:flutter/material.dart';

class DetailVideoPage extends StatefulWidget {
  const DetailVideoPage({Key? key, required this.video}) : super(key: key);
  final VideoModel video;

  @override
  _DetailVideoPageState createState() => _DetailVideoPageState();
}

class _DetailVideoPageState extends State<DetailVideoPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late BetterPlayerController _betterPlayerController;
  final GlobalKey _betterPlayerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            title: Text(widget.video.title),
            leading: const CloseButton(),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BetterPlayer(
                  key: _betterPlayerKey,
                  controller: _betterPlayerController,
                ),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, widget) => Transform.translate(
                    transformHitTests: false,
                    offset: Offset.lerp(
                        Offset(0.0, 200.0), Offset.zero, _controller.value)!,
                    child: widget,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.video.title,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          widget.video.description,
                          maxLines: 14,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _betterPlayerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
      autoPlay: true,
    );
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.video.videoUrl,
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
    _betterPlayerController.setBetterPlayerGlobalKey(_betterPlayerKey);
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _controller.forward();

    super.initState();
  }
}
