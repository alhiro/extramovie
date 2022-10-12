import 'package:extramile_movie/constants.dart';
import 'package:extramile_movie/controller/discover_controller.dart';
import 'package:extramile_movie/controller/movie_video_controller.dart';
import 'package:extramile_movie/controller/review_user_controller.dart';
import 'package:extramile_movie/model/detail_discover_model.dart';
import 'package:extramile_movie/model/movie_video_model.dart';
import 'package:extramile_movie/model/review_user_model.dart';
import 'package:extramile_movie/screens/detail_discover/components/movie_video.dart';
import 'package:extramile_movie/screens/detail_discover/components/review_user.dart';
import 'package:extramile_movie/size_config.dart';
import 'package:flutter/material.dart';

import 'detail_discover.dart';

class Body extends StatefulWidget {
  final int? discoverId;

  const Body({super.key, required this.discoverId});

  @override
  // ignore: library_private_types_in_public_api
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final DiscoverController discoverController = DiscoverController.to;
  final ReviewUserController reviewUserController = ReviewUserController.to;
  final MovieVideoController movieVideoController = MovieVideoController.to;

  MovieDetailDiscover? detailMovie;
  List<MovieReviewUser> listReview = [];
  List<MovieVideo> listVideo = [];

  int page = 1;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await discoverController.handleGetDetailDiscoverByGenre(widget.discoverId);
    await reviewUserController.handleReviewUser(widget.discoverId, page);
    await movieVideoController.handleMovieVideo(widget.discoverId);

    setState(() {
      detailMovie = discoverController.detailDiscoverGenre.value;
      listReview = reviewUserController.reviewUsers;
      listVideo = movieVideoController.videos
          .where((x) => x.name == "Official Trailer")
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.ebonyClay,
      child: RefreshIndicator(
        onRefresh: refreshData,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                GetDetailDiscover(discover: detailMovie),
                SizedBox(height: getProportionateScreenHeight(50)),
                GetMovieVideo(videos: listVideo),
                SizedBox(height: getProportionateScreenHeight(25)),
                GetReviewUser(reviews: listReview)
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Future refreshData() async {}
}
