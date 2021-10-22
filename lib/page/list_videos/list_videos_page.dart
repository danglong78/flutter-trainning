import 'package:better_player/better_player.dart';
import 'package:demo_retrofit_moor/bloc/dogs/dogs_bloc.dart';
import 'package:demo_retrofit_moor/const.dart';
import 'package:demo_retrofit_moor/model/video_model.dart';
import 'package:demo_retrofit_moor/page/home/home_page.dart';
import 'package:demo_retrofit_moor/page/list_videos/video_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListVideosPage extends StatefulWidget {
  const ListVideosPage({Key? key}) : super(key: key);

  @override
  _ListVideosPageState createState() => _ListVideosPageState();
}

class _ListVideosPageState extends State<ListVideosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return BlocProvider(
                    create: (BuildContext context) => DogsBloc(),
                    child: const HomePage());
              }));
            },
            icon: Icon(Icons.arrow_back_rounded),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: media.length,
        itemBuilder: (context, index) {
          return VideoCard(
            video: VideoModel.fromJson(media[index]),
          );
        },
      ),
    );
  }
}
