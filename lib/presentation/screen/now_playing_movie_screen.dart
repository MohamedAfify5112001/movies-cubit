import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_cubit/core/managers/app_sizes.dart';
import 'package:movie_cubit/core/managers/color_manager.dart';
import 'package:movie_cubit/core/managers/strings_manager.dart';
import 'package:movie_cubit/model/now_playing_model.dart';
import 'package:movie_cubit/presentation/components/text_component.dart';

import '../components/sized_box.dart';
import 'cubit/now_playing_cubit.dart';
import 'cubit/now_playing_state.dart';

class NowPlayingMovieScreen extends StatelessWidget {
  const NowPlayingMovieScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingCubit, NowPlayingState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const TextComponent(
              text: StringsManager.nowPlayingMovie,
              color: AppColors.whiteColor,
              fontSize: AppSizes.s18,
            ),
          ),
          body: (state is SuccessNowPlayingState)
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p11, vertical: AppPadding.p12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildMovieDetails(
                              context
                                  .watch<NowPlayingCubit>()
                                  .nowPlayingMovies[index]),
                          separatorBuilder: (context, index) =>
                              sizedBoxComponentForHeight(height: AppSizes.s8),
                          itemCount: context
                              .watch<NowPlayingCubit>()
                              .nowPlayingMovies
                              .length,
                        ),
                      )
                    ],
                  ),
                )
              : (state is FailedNowPlayingState)
                  ? Center(
                      child: TextComponent(
                        text: state.errorModel.statusMessage,
                        color: AppColors.whiteColor,
                        fontSize: AppSizes.s25,
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.whiteColor,
                      ),
                    ),
        );
      },
    );
  }

  Card buildMovieDetails(NowPlayingModel nowPlayingModel) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSizes.s15))),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p11, vertical: AppPadding.p8),
        child: Row(
          children: [
            _buildMovieImage(nowPlayingModel.backdropPath),
            sizedBoxComponentForWidth(width: AppPadding.p11),
            _buildMovieData(nowPlayingModel),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieImage(String image) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(AppSizes.s15)),
      child: Image(
          width: AppSizes.s150,
          height: AppSizes.s250,
          fit: BoxFit.cover,
          image: NetworkImage(image)),
    );
  }

  Widget _buildMovieData(NowPlayingModel nowPlayingModel) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [_buildReleaseData(nowPlayingModel.releaseDate)],
          ),
          sizedBoxComponentForHeight(height: AppSizes.s10),
          TextComponent(
            text: nowPlayingModel.originalTitle,
            color: AppColors.whiteColor,
            fontSize: AppSizes.s25,
            fontWeight: FontWeight.w600,
          ),
          sizedBoxComponentForHeight(height: AppSizes.s8),
          TextComponent(
            text: nowPlayingModel.overview,
            color: AppColors.whiteColor,
            fontSize: AppSizes.s12,
            fontWeight: FontWeight.w300,
            maxLines: AppSizes.s3,
            overflow: TextOverflow.ellipsis,
          ),
          sizedBoxComponentForHeight(height: AppSizes.s60),
          _buildWatchNowButton()
        ],
      ),
    );
  }

  Widget _buildReleaseData(String releaseDate) {
    String year = releaseDate.split('-')[0];
    return Container(
      width: 50,
      height: 28,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(AppSizes.s8)),
        color: AppColors.primaryColor,
      ),
      child: Center(
        child: TextComponent(
          text: year,
          fontSize: AppSizes.s15,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }

  Widget _buildWatchNowButton() {
    return SizedBox(
      width: double.infinity,
      child: MaterialButton(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSizes.s18))),
        onPressed: () {},
        color: AppColors.primaryColor,
        child: const TextComponent(
          text: StringsManager.watchNow,
          color: AppColors.whiteColor,
          fontSize: AppSizes.s18,
        ),
      ),
    );
  }
}
