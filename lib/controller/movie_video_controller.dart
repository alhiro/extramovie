import 'package:dio/dio.dart';
import 'package:extramile_movie/model/movie_video_model.dart';
import 'package:extramile_movie/service/movie_video_services.dart';
import 'package:get/get.dart' hide Response;

class MovieVideoController extends GetxController {
  static MovieVideoController to = Get.find();
  late MovieVideoServices _movieVideoServices;

  // movie video
  RxBool isLoadingVideo = false.obs;
  RxString errorMessageVideo = ''.obs;
  RxList<MovieVideo> videos = RxList<MovieVideo>();

  MovieVideoController() {
    _movieVideoServices = MovieVideoServices();
  }

  handleMovieVideo(int? movieId) async {
    try {
      isLoadingVideo.value = true;

      Response result = await _movieVideoServices.getMovieVideo(movieId);
      var jsonData = result.data;

      if (result.statusCode != 200) {
        errorMessageVideo.value = jsonData['message'];
      } else {
        List result = jsonData['results'];
        videos.assignAll(result.map((e) => MovieVideo.fromJson(e)).toList());
      }

      isLoadingVideo.value = false;
    } catch (e) {
      isLoadingVideo.value = false;
    }
  }
}
