import 'package:movie_cubit/core/constants/app_constants.dart';
import 'package:movie_cubit/core/managers/color_manager.dart';

class NowPlayingModel {
  final int id;
  final String originalTitle;
  final String backdropPath;
  final String overview;
  final String releaseDate;

  NowPlayingModel(
      {required this.id,
      required this.originalTitle,
      required this.backdropPath,
      required this.overview,
      required this.releaseDate});

  factory NowPlayingModel.fromJson(Map<String, dynamic> json) =>
      NowPlayingModel(
        id: json["id"],
        originalTitle: json["original_title"],
        backdropPath: AppConstants.imageUrl + json["backdrop_path"],
        overview: json["overview"],
        releaseDate: json["release_date"],
      );
}
