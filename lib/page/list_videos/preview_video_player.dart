import 'dart:async';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class PreviewVideoPlayer extends StatefulWidget {
  const PreviewVideoPlayer({Key? key, required this.videoUrl})
      : super(key: key);
  final String videoUrl;
  @override
  _PreviewVideoPlayerState createState() => _PreviewVideoPlayerState();
}

class _PreviewVideoPlayerState extends State<PreviewVideoPlayer> {
  late BetterPlayerController _betterPlayerController;
  final GlobalKey _betterPlayerKey = GlobalKey();

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
      widget.videoUrl,
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
    _betterPlayerController.setBetterPlayerGlobalKey(_betterPlayerKey);
    _betterPlayerController.setControlsEnabled(false);
    _betterPlayerController.addEventsListener((event) {});
    super.initState();
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BetterPlayer(
      controller: _betterPlayerController,
      key: _betterPlayerKey,
    );
  }
}
