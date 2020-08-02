import 'package:alap/bloc_models/base_state.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 8/1/2020 8:21 PM
///





/// Initialized
class VideoState extends BaseState {

  VideoState();

  @override
  String toString() => 'VideoState';

  @override
  BaseState getStateCopy() {
    return VideoState();
  }
}

///loaded
class VideoLoadedState extends BaseState{
  VideoLoadedState();

  @override
  String toString() => 'VideoLoadedState';

  @override
  BaseState getStateCopy() {
    return VideoLoadedState();
  }
}
