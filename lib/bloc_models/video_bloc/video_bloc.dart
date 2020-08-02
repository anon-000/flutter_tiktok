
import 'dart:async';
import 'dart:developer' as developer;
import 'package:alap/bloc_models/base_state.dart';
import 'package:alap/bloc_models/video_bloc/index.dart';
import 'package:alap/data_models/video_data.dart';
import 'package:bloc/bloc.dart';



///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 8/1/2020 8:21 PM
///
///


class VideoBloc extends Bloc<VideoEvent, BaseState> {

  static final VideoBloc _videoBlocSingleton = VideoBloc
      ._internal();

  factory VideoBloc() {
    return _videoBlocSingleton;
  }

  VideoBloc._internal() : super(VideoState());

  @override
  Future<void> close() async {
    _videoBlocSingleton.close();
    await super.close();
  }

  List<VideoDatum> videos = [];
  int videoSkip = 0;
  int videoLimit = 8;
  bool shouldVideoLoadMore = true;

  @override
  Stream<BaseState> mapEventToState(VideoEvent event,) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log(
          '$_', name: 'VideoBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}

