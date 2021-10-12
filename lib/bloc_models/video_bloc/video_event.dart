import 'package:alap/api_services/video_api_services.dart';
import 'package:alap/bloc_models/base_state.dart';
import 'package:alap/bloc_models/video_bloc/index.dart';
import 'package:flutter/material.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 8/1/2020 8:21 PM
///

@immutable
abstract class VideoEvent {
  Stream<BaseState> applyAsync({BaseState currentState, VideoBloc bloc});
}

class LoadVideosEvent extends VideoEvent {
  @override
  Stream<BaseState> applyAsync(
      {BaseState? currentState, VideoBloc? bloc}) async* {
    try {
      yield LoadingBaseState();
      bloc!.videoSkip = 0;
      bloc.shouldVideoLoadMore = true;
      final videos =
          await getAllVideos(skip: bloc.videoSkip, limit: bloc.videoLimit);
      if (videos.data!.length < bloc.videoLimit)
        bloc.shouldVideoLoadMore = false;

      if (videos.data!.isEmpty) {
        yield EmptyBaseState();
      } else {
        bloc.videos = videos.data ?? [];
        yield VideoLoadedState();
      }
    } catch (_, s) {
      print(_.toString());
      print(s.toString());
      yield ErrorBaseState("$_");
    }
  }
}

class LoadMoreVideosEvent extends VideoEvent {
  @override
  Stream<BaseState> applyAsync(
      {BaseState? currentState, VideoBloc? bloc}) async* {
    try {
      if (bloc!.shouldVideoLoadMore) {
        bloc!.videoSkip = bloc.videos.length;
        final moreVideos =
            await getAllVideos(skip: bloc.videoSkip, limit: bloc.videoLimit);
        if (moreVideos.data!.length < bloc.videoLimit)
          bloc.shouldVideoLoadMore = false;

        bloc.videos += moreVideos.data ?? [];

        yield VideoLoadedState();
      } else {
        yield currentState!;
      }
    } catch (_, st) {
      print(st.toString());
      yield currentState!;
    }
  }
}
