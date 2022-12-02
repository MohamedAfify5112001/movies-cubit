import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_cubit/core/constants/app_constants.dart';
import 'package:movie_cubit/model/error_model.dart';
import 'package:movie_cubit/presentation/screen/cubit/now_playing_state.dart';

import '../../../core/network/network_service.dart';
import '../../../model/now_playing_model.dart';

class NowPlayingCubit extends Cubit<NowPlayingState> {
  List<NowPlayingModel> nowPlayingMovies = [];

  NowPlayingCubit() : super(InitNowPlayingState());

  static NowPlayingCubit instance(context) => BlocProvider.of(context);

  void getNowPlayingMovie() async {
    emit(LoadingNowPlayingState());
    try {
      Response response = await NetworkService.getData(
          endPoint: AppConstants.nowPlayingEndPoint);
      if (response.statusCode == 200) {
        List result = (response.data['results']) as List;
        nowPlayingMovies = result
            .map((nowPlayingMovie) => NowPlayingModel.fromJson(nowPlayingMovie))
            .toList();
        emit(SuccessNowPlayingState());
      }
    } on DioError catch (error) {
      ErrorModel errorModel =
          ErrorModel(statusMessage: error.response!.statusMessage!);
      emit(FailedNowPlayingState(errorModel: errorModel));
    }
  }
}
