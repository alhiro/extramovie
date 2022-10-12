import 'package:dio/dio.dart';
import 'package:extramile_movie/model/review_user_model.dart';
import 'package:extramile_movie/service/review_user_services.dart';
import 'package:get/get.dart' hide Response;

class ReviewUserController extends GetxController {
  static ReviewUserController to = Get.find();
  late ReviewUserServices _reviewUserServices;

  // review user
  RxBool isLoadingReviewUser = false.obs;
  RxString errorMessageReviewUser = ''.obs;
  RxList<MovieReviewUser> reviewUsers = RxList<MovieReviewUser>();

  ReviewUserController() {
    _reviewUserServices = ReviewUserServices();
  }

  handleReviewUser(int? movieId, int? page) async {
    try {
      isLoadingReviewUser.value = true;

      Response result = await _reviewUserServices.getReviewUser(movieId, page);
      var jsonData = result.data;

      if (result.statusCode != 200) {
        errorMessageReviewUser.value = jsonData['message'];
      } else {
        List result = jsonData['results'];
        reviewUsers
            .assignAll(result.map((e) => MovieReviewUser.fromJson(e)).toList());
      }

      isLoadingReviewUser.value = false;
    } catch (e) {
      isLoadingReviewUser.value = false;
    }
  }
}
