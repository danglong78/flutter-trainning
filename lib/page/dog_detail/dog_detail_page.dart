import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_retrofit_moor/data/local/database.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DogDetailPage extends StatefulWidget {
  final List<Dog> dogs;
  final int index;

  const DogDetailPage({
    Key? key,
    required this.dogs,
    required this.index,
  }) : super(key: key);

  @override
  _DogDetailPageState createState() => _DogDetailPageState(
      name: dogs[index].name, describe: dogs[index].describe);
}

class _DogDetailPageState extends State<DogDetailPage>
    with SingleTickerProviderStateMixin {
  _DogDetailPageState({required this.name, required this.describe});

  late AnimationController _controller;
  final CarouselController _carouselController = CarouselController();
  late CarouselOptions _carouselOptions;
  String name;
  String describe;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _controller.forward();
    _carouselOptions = CarouselOptions(
      enlargeCenterPage: true,
      viewportFraction: 1,
      initialPage: widget.index,
      onPageChanged: (index, reason) {
        setState(() {
          name = widget.dogs[index].name;
          describe = widget.dogs[index].describe;
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: "background_${widget.dogs[widget.index].name}",
          child: Container(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            title: Text(name),
            leading: const CloseButton(),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Hero(
                  tag: "image_${name}",
                  child: CarouselSlider.builder(
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      return widget.dogs[index].isFile
                          ? Image(
                              image: FileImage(File(widget.dogs[index].url)),
                              width: double.infinity,
                              fit: BoxFit.fill,
                            )
                          : CachedNetworkImage(
                              width: double.infinity,
                              fit: BoxFit.fill,
                              progressIndicatorBuilder:
                                  (context, url, progress) =>
                                      LinearProgressIndicator(
                                value: progress.progress,
                              ),
                              errorWidget: (context, url, error) => Icon(
                                Icons.image,
                                size: MediaQuery.of(context).size.height / 5,
                              ),
                              imageUrl: widget.dogs[index].url,
                            );
                    },
                    itemCount: widget.dogs.length,
                    options: _carouselOptions,
                    carouselController: _carouselController,
                  ),
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
                    child: Text(
                      describe,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
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
}
