import 'package:movie_cubit/model/error_model.dart';

abstract class NowPlayingState {}

class InitNowPlayingState extends NowPlayingState {}

class SuccessNowPlayingState extends NowPlayingState {}

class FailedNowPlayingState extends NowPlayingState {
  final ErrorModel errorModel;

  FailedNowPlayingState({required this.errorModel});
}

class LoadingNowPlayingState extends NowPlayingState {}
