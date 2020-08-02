///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 8/1/2020 7:44 PM
///



abstract class BaseState {
  final List properties;
  BaseState([this.properties]);
  BaseState getStateCopy();
  List<Object> get props => ([...properties ?? []]);
}

/// UnInitialized
class UnBaseState extends BaseState {
  @override
  String toString() => 'UnBaseState';

  @override
  UnBaseState getStateCopy() {
    return UnBaseState();
  }
}

/// Error base state
class ErrorBaseState extends BaseState {
  final String errorMessage;

  ErrorBaseState(this.errorMessage) : super([errorMessage]);

  @override
  String toString() => 'ErrorBaseState';

  @override
  ErrorBaseState getStateCopy() {
    return ErrorBaseState(this.errorMessage);
  }
}

/// Empty base state
class EmptyBaseState extends BaseState {
  @override
  String toString() => 'EmptyBaseState';

  @override
  EmptyBaseState getStateCopy() {
    return EmptyBaseState();
  }
}

/// Loading base state
class LoadingBaseState extends BaseState {
  @override
  String toString() => 'LoadingBaseState';

  @override
  LoadingBaseState getStateCopy() {
    return LoadingBaseState();
  }
}

