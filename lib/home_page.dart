import 'package:alap/components/music_details_section.dart';
import 'package:alap/components/nav_bar.dart';
import 'package:alap/components/side_options_bar.dart';
import 'package:alap/flickr/flick_multi_manager.dart';
import 'package:alap/flickr/flick_multi_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widgets/flutter_widgets.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/31/2020 7:15 PM
///

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> videoUrls = [
    'https://alap-video.s3.ap-south-1.amazonaws.com/video_Babushan+movie+vdo/1596203065673_Babushan+movie+vdo.mp4',
    'https://alap-video.s3.ap-south-1.amazonaws.com/video_fly+car/1596207704991_fly+car.mp4',
    'https://alap-video.s3.ap-south-1.amazonaws.com/video_life+hack/1596207895680_life+hack.mp4',
    'https://alap-video.s3.ap-south-1.amazonaws.com/video_surf+pi+scenee/1596208202166_surf+pi+scenee.mp4',
    'https://alap-video.s3.ap-south-1.amazonaws.com/video_bombom+challenge/1596207557472_bombom+challenge.mp4'
  ];
  List<String> thumbUrls = [
    'https://alap-video.s3.ap-south-1.amazonaws.com/video_Babushan+movie+vdo/1596203072142_vlcsnap-2020-07-31-19h12m43s788.jpg',
    'https://alap-video.s3.ap-south-1.amazonaws.com/video_fly+car/1596207708555_vlcsnap-2020-07-31-20h31m09s554.jpg',
    'https://alap-video.s3.ap-south-1.amazonaws.com/video_life+hack/1596207900844_vlcsnap-2020-07-31-20h34m26s034.jpg',
    'https://alap-video.s3.ap-south-1.amazonaws.com/video_surf+pi+scenee/1596208207915_vlcsnap-2020-07-31-20h39m28s282.jpg',
    'https://alap-video.s3.ap-south-1.amazonaws.com/video_bombom+challenge/1596207562934_vlcsnap-2020-07-31-20h28m05s057.jpg'
  ];
  FlickMultiManager flickMultiManager;

  @override
  void initState() {
    flickMultiManager = FlickMultiManager();
    super.initState();
  }

  @override
  void dispose() {
    flickMultiManager.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: VisibilityDetector(
            key: ObjectKey(flickMultiManager),
            onVisibilityChanged: (visibility) {
              if (visibility.visibleFraction == 0 && this.mounted) {
                flickMultiManager.pause();
              }
            },
               child: Container(
                child: PageView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) => Container(
                            child: ClipRRect(
                              child: FlickMultiPlayer(
                                url: videoUrls[index],
                                flickMultiManager: flickMultiManager,
                                image: thumbUrls[index],
                              ),
                            ),
//                    child: Center(child: Text(index.toString()),),
                    )),
              ),
          )),
          Positioned(
            bottom: 75,
              right: 17,
              child: SideOptionsBar()
          ),
          Positioned(
            width:width ,
              bottom:0,
              child: NavBar()
          ),
          Positioned(
              width:width/1.3 ,
              bottom:75,
              child: MusicDetailsSection()
          ),
          Positioned(
            top: 50,
              right: 0,
              left: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Following" , style: TextStyle(fontSize: 17,color: Colors.white.withOpacity(0.5), fontWeight: FontWeight.w600),),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("For You", style: TextStyle(fontSize: 17,color: Colors.white, fontWeight: FontWeight.w600)),
              )
            ],
          ))
        ],
      ),
    );
  }
}
