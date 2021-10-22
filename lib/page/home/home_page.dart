import 'package:demo_retrofit_moor/bloc/dogs/dogs_bloc.dart';
import 'package:demo_retrofit_moor/data/local/database.dart';

import 'package:demo_retrofit_moor/page/list_videos/list_videos_page.dart';
import 'package:demo_retrofit_moor/page/test_interceptor/test_interceptor_page.dart';
import 'package:demo_retrofit_moor/page/upload/upload_page.dart';
import 'package:demo_retrofit_moor/provider/login_provider.dart';
import 'package:demo_retrofit_moor/provider/theme_provider.dart';
import 'package:demo_retrofit_moor/page/dog_detail/dog_detail_page.dart';
import 'package:demo_retrofit_moor/page/home/list_item.dart';
import 'package:demo_retrofit_moor/service/upload_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../widget/error_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var isPink = true;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final ScrollController _scrollController = ScrollController();
  _goToDetail(List<Dog> dogs, int index) {
    final page = DogDetailPage(dogs: dogs, index: index);
    Navigator.of(context).push(
      PageRouteBuilder<void>(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return AnimatedBuilder(
                animation: animation,
                builder: (BuildContext context, Widget? child) {
                  return Opacity(
                    opacity: animation.value,
                    child: page,
                  );
                });
          },
          transitionDuration: Duration(milliseconds: 200)),
    );
  }

  _goToListVideo() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
      return ListVideosPage();
    }));
  }

  @override
  void initState() {
    UploadService.instance.reUploadImage();

    BlocProvider.of<DogsBloc>(context).add(DogsInitiate());
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        BlocProvider.of<DogsBloc>(context).add(DogsLoadMore());
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        TestInterceptorPage(),
                  ));
                },
                icon: const Icon(Icons.quiz)),
            IconButton(
                onPressed: () {
                  _goToListVideo();
                },
                icon: const Icon(Icons.video_library)),
            IconButton(
                onPressed: () {
                  Provider.of<LoginProvider>(context, listen: false).logOut();
                },
                icon: const Icon(Icons.logout)),
            IconButton(
                icon: const Icon(Icons.download),
                onPressed: () {
                  BlocProvider.of<DogsBloc>(context).add(DogsFetchData());
                }),
            IconButton(
                icon: const Icon(Icons.file_upload),
                onPressed: () {
                  Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        UploadPage(),
                  ));
                }),
            Switch(
              value: isPink,
              onChanged: (value) {
                setState(() {
                  isPink = !isPink;
                });
                Provider.of<ThemeProvider>(context, listen: false)
                    .changeTheme();
              },
              activeTrackColor: Theme.of(context).colorScheme.secondary,
              activeColor: Theme.of(context).colorScheme.onSecondary,
              inactiveTrackColor: Theme.of(context).colorScheme.secondary,
            ),
          ],
        ),
        body: BlocConsumer<DogsBloc, DogsState>(listener: (context, state) {
          if (state is DogsLoadError) {
            showDialog(
              context: context,
              builder: (context) {
                return ErrorDialog(state.error);
              },
            ).whenComplete(
                () => BlocProvider.of<DogsBloc>(context).add(DogsInitiate()));
          }
        }, builder: (context, state) {
          if (state is DogsLoadInitial || state is DogsLoadError)
            return Container();
          else if (state is DogsLoadInProgress)
            return const Center(child: CircularProgressIndicator());
          else {
            var dogs = (state as DogsLoadSuccess).listDogs;
            return SmartRefresher(
              enablePullDown: true,
              physics: BouncingScrollPhysics(),
              header: WaterDropMaterialHeader(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 2));
                BlocProvider.of<DogsBloc>(context).add(DogsRefresh());
                _refreshController.refreshCompleted();
              },
              controller: _refreshController,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: dogs.length + 1,
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    if (index < dogs.length) {
                      var currentDog =
                          (state as DogsLoadSuccess).listDogs[index];
                      return ListItem(
                        dog: currentDog,
                        onTap: () {
                          _goToDetail(dogs, index);
                        },
                      );
                    } else if ((state).hasMore)
                      return Center(child: CircularProgressIndicator());
                    else
                      return Center(child: Text("Nothing to load more"));
                  }),
            );
          }
        }));
  }
}
