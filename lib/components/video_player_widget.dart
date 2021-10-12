import 'dart:async';
import 'dart:math';

import 'package:alap/components/music_details_section.dart';
import 'package:alap/components/side_options_bar.dart';
import 'package:alap/data_models/video_data.dart';
import 'package:alap/flickr/flick_multi_manager.dart';
import 'package:alap/flickr/flick_multi_player.dart';
import 'package:flutter/material.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 8/2/2020 8:37 AM
///

class VideoPlayerWidget extends StatefulWidget {
  final VideoDatum? data;
  final FlickMultiManager? flickMultiManager;

  VideoPlayerWidget({this.flickMultiManager, this.data});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _heartOffsetController;
  late Animation<double> animation;
  bool isPlaying = true;
  double posx = 100.0;
  double posy = 100.0;
  Random random = Random();
  double heartOpacity = 0;
  bool heartIn = true;
  double longPosX = 0;
  double longPosY = 0;
  int heartsLength = 1;
  bool isMaxHeart = false;
  Timer? _timer;
  double _start = 0;

  void startTimer() {
    const oneSec = const Duration(milliseconds: 250);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          heartsLength++;
          _start = _start + 0.5;
        },
      ),
    );
  }

  void onTapDown(BuildContext context, TapDownDetails details) {
    print('On Tap Down : ${details.globalPosition}');
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    setState(() {
      posx = localOffset.dx;
      posy = localOffset.dy;
      heartOpacity = 1;
    });
    _controller.forward().then((value) {
      _controller.reverse().then((value) {
        _controller.forward().whenComplete(() {
          setState(() {
            heartOpacity = 0;
          });
        });
      });
    });
  }

  void onLiked(double height, double width) {
    setState(() {
      posx = width / 2 - 15;
      posy = height / 2 - 10;
      heartOpacity = 1;
    });
    _controller.forward().then((value) {
      _controller.reverse().then((value) {
        _controller.forward().whenComplete(() {
          setState(() {
            heartOpacity = 0;
          });
        });
      });
    });
  }

  onLongPressStart(BuildContext context, LongPressStartDetails details) {
    startTimer();
    _heartOffsetController.reset();
    setState(() {
      isMaxHeart = true;
    });

    print('LongPress : ${details.globalPosition}');
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    setState(() {
      longPosX = localOffset.dx;
      longPosY = localOffset.dy;
    });
    _heartOffsetController.forward().then((value) {
      setState(() {
        isMaxHeart = false;
      });
    });
  }

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    _heartOffsetController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation =
        Tween<double>(begin: 0.0, end: 150.0).animate(_heartOffsetController);

    _heartOffsetController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _heartOffsetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onSecondaryTapDown: (TapDownDetails details) => print("secondary tap up"),
      onLongPressStart: (LongPressStartDetails details) =>
          onLongPressStart(context, details),
      onTapDown: (TapDownDetails details) => onTapDown(context, details),
      onLongPressEnd: (LongPressEndDetails d) {
        _timer!.cancel();
        setState(() {
          heartsLength = 1;
        });
      },
      child: Stack(
        children: [
          FlickMultiPlayer(
            url: widget.data!.video!,
            flickMultiManager: widget.flickMultiManager,
            image: widget.data!.thumbnail!,
            isPlaying: (result) {
              setState(() {
                isPlaying = result;
              });
            },
          ),
          Positioned(
            top: posy - 35,
            left: posx - 35,
            child: ScaleTransition(
                scale: Tween(begin: 0.80, end: 1.3).animate(CurvedAnimation(
                    parent: _controller, curve: Curves.elasticIn)),
                child: AnimatedOpacity(
                    duration: heartIn
                        ? Duration(milliseconds: 100)
                        : Duration(milliseconds: 400),
                    opacity: heartOpacity,
                    child: Transform.rotate(
                        angle: posx > width / 2 + 20
                            ? pi / 6
                            : posx < width / 2 - 20
                                ? -pi / 6
                                : 0,
                        child: Icon(
                          Icons.favorite,
                          size: 100,
                          color: Colors.red.withOpacity(0.8),
                        )))),
          ),
          Positioned(
            top: longPosY,
            left: longPosX - 10,
            child: Column(
              children: List.generate(
                  heartsLength,
                  (index) => Transform.translate(
                        offset: Offset(0, -animation.value),
                        child: AnimatedOpacity(
                            opacity: isMaxHeart ? 1 : 0,
                            duration: Duration(milliseconds: 300),
                            child: Icon(
                              Icons.favorite,
                              size: 50,
                              color: Colors.teal,
                            )),
                      )),
            ),
          ),
          Positioned(
              bottom: 75,
              right: 17,
              child: SideOptionsBar(
                isPlaying: isPlaying,
                onLiked: () {
                  print("Like Clicked");
                  onLiked(height, width);
                },
              )),
          Positioned(
              width: width / 1.3,
              bottom: 75,
              child: MusicDetailsSection(
                name: widget.data!.name!,
              )),
        ],
      ),
    );
  }
}
