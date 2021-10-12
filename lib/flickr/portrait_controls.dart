import 'package:alap/flickr/flick_multi_manager.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/31/2020 9:55 PM
///
///
///

import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flick_video_player/flick_video_player.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

class FeedPlayerPortraitControls extends StatelessWidget {
  const FeedPlayerPortraitControls(
      {Key? key, this.flickMultiManager, this.flickManager, this.isPlaying})
      : super(key: key);

  final FlickMultiManager? flickMultiManager;
  final FlickManager? flickManager;
  final Function(bool playing)? isPlaying;

  @override
  Widget build(BuildContext context) {
    FlickDisplayManager displayManager =
        Provider.of<FlickDisplayManager>(context);
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
//          FlickAutoHideChild(
//            showIfVideoNotInitialized: false,
//            child: Align(
//              alignment: Alignment.topRight,
//              child: Container(
//                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//                decoration: BoxDecoration(
//                  color: Colors.black38,
//                  borderRadius: BorderRadius.circular(20),
//                ),
//                child: FlickLeftDuration(),
//              ),
//            ),
//          ),
          Expanded(
              child: Container(
            child: Center(
              child: AnimatedOpacity(
                opacity:
                    flickManager!.flickVideoManager.videoPlayerValue.isPlaying
                        ? 0
                        : 1,
                duration: Duration(milliseconds: 300),
                child: FlickPlayToggle(
                  togglePlay: () {
                    print("toggle tap");
                    flickMultiManager!.togglePlay(flickManager!);
                    displayManager.handleShowPlayerControls();
                    if (flickManager!.flickVideoManager.isPlaying) {
                      isPlaying!.call(true);
                    } else {
                      isPlaying!.call(false);
                    }
                  },
                  playChild: Icon(
                    Icons.play_arrow,
                    size: 120,
                    color: Colors.white.withOpacity(0.8),
                  ),
                  pauseChild: Icon(Icons.pause,
                      size: 120, color: Colors.white.withOpacity(0.7)),
                ),
              ),
            ),
          ))

//          Expanded(
//            child: FlickTogglePlayAction(
//              togglePlay: () {
//                flickMultiManager.togglePlay(flickManager);
//                displayManager.handleShowPlayerControls();
//              },
//              child: Center(child: FlickAutoHideChild(
//                autoHide: true,
//                showIfVideoNotInitialized: false,
//                child: FlickPlayToggle(
//                  playChild: Icon(Icons.play_arrow, size: 100, color: Colors.white.withOpacity(0.8),),
//                  pauseChild: Icon(Icons.pause, size: 100, color: Colors.white.withOpacity(0.7)),
//                ),
//              )),
//            ),
//          ),
//          FlickAutoHideChild(
//            autoHide: true,
//            showIfVideoNotInitialized: false,
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.end,
//              children: <Widget>[
//                Container(
//                  padding: EdgeInsets.all(2),
//                  decoration: BoxDecoration(
//                    color: Colors.black38,
//                    borderRadius: BorderRadius.circular(20),
//                  ),
//                  child: FlickSoundToggle(
//                    toggleMute: () => flickMultiManager.toggleMute(),
//                    color: Colors.white,
//                  ),
//                ),
//                // FlickFullScreenToggle(),
//              ],
//            ),
//          ),
        ],
      ),
    );
  }
}
