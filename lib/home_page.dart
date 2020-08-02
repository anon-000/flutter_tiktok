import 'package:alap/bloc_models/base_state.dart';
import 'package:alap/bloc_models/video_bloc/index.dart';
import 'package:alap/components/music_details_section.dart';
import 'package:alap/components/nav_bar.dart';
import 'package:alap/components/side_options_bar.dart';
import 'package:alap/components/video_player_widget.dart';
import 'package:alap/flickr/flick_multi_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widgets/flutter_widgets.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/31/2020 7:15 PM
///

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlickMultiManager flickMultiManager;

  @override
  void initState() {
    flickMultiManager = FlickMultiManager();
    super.initState();
    VideoBloc().add(LoadVideosEvent());
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
                child: BlocBuilder<VideoBloc, BaseState>(
                    bloc: VideoBloc(),
                    builder: (context, BaseState state){
                      if(state is LoadingBaseState){
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if(state is EmptyBaseState){
                        return Center(
                          child: Text("No Videos Available"),
                        );
                      }
                      if(state is ErrorBaseState){
                        return Center(
                          child: Text(state.errorMessage),
                        );
                      }
                      if(state is VideoLoadedState){
                        return PageView.builder(
                          onPageChanged: (i){
                            print("Page numberrrrrrrrrrrrrr  ::::::::::::::::::::"+i.toString());
                            if( i == VideoBloc().videos.length-5){
                              if(VideoBloc().videos.length - i <= 5)
                                VideoBloc().add(LoadMoreVideosEvent());
                            }
                          },
                          itemCount: VideoBloc().shouldVideoLoadMore
                              ? VideoBloc().videos.length + 1
                              : VideoBloc().videos.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index){
                            return index >
                                VideoBloc().videos.length
                                ? VideoBloc().shouldVideoLoadMore
                                ? CircularProgressIndicator()
                                : Container()
                                : Container(
                              child: VideoPlayerWidget(
                                flickMultiManager: flickMultiManager,
                                data: VideoBloc().videos[index],
                              ),
//                    child: Center(child: Text(index.toString()),),
                            );
                          }
                        );
                    }
                      return SizedBox(height: 0,
                        width: width/2,);
                    }
                ),
              ),
          )),
          Positioned(
            width:width ,
              bottom:0,
              child: NavBar()
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
