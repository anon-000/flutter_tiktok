import 'package:alap/flickr/portrait_controls.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/31/2020 9:53 PM
///
///

import './flick_multi_manager.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flick_video_player/flick_video_player.dart';

import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_widgets/flutter_widgets.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:video_player/video_player.dart';

class FlickMultiPlayer extends StatefulWidget {
  const FlickMultiPlayer(
      {Key? key,
      this.url = '',
      this.image = '',
      this.flickMultiManager,
      this.isPlaying})
      : super(key: key);

  final String url;
  final String image;
  final FlickMultiManager? flickMultiManager;
  final Function(bool result)? isPlaying;

  @override
  _FlickMultiPlayerState createState() => _FlickMultiPlayerState();
}

class _FlickMultiPlayerState extends State<FlickMultiPlayer> {
  late FlickManager flickManager;

  @override
  void initState() {
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(widget.url)
        ..setLooping(true),
      autoPlay: false,
    );
    widget.flickMultiManager!.init(flickManager);
    super.initState();
  }

  @override
  void dispose() {
    widget.flickMultiManager!.remove(flickManager);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(flickManager),
      onVisibilityChanged: (visiblityInfo) {
        if (visiblityInfo.visibleFraction > 0.9) {
          widget.flickMultiManager!.play(flickManager);
        }
      },
      child: Container(
        child: FlickVideoPlayer(
          flickManager: flickManager,
          flickVideoWithControls: FlickVideoWithControls(
            playerLoadingFallback: Positioned.fill(
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Image.asset(
                      widget.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Container(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        strokeWidth: 4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            controls: FeedPlayerPortraitControls(
              isPlaying: (result) {
                print("result from control :" + result.toString());
                widget.isPlaying!.call(result);
              },
              flickMultiManager: widget.flickMultiManager!,
              flickManager: flickManager,
            ),
          ),
          flickVideoWithControlsFullscreen: FlickVideoWithControls(
            playerLoadingFallback: Center(
                child: Image.network(
              widget.image,
              fit: BoxFit.fitWidth,
            )),
            controls: FlickLandscapeControls(),
            iconThemeData: IconThemeData(
              size: 40,
              color: Colors.white,
            ),
            textStyle: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
