import 'package:dio/dio.dart';
import 'package:extramile_movie/model/genre_model.dart';
import 'package:extramile_movie/service/genre_services.dart';
import 'package:get/get.dart' hide Response;

class GenreController extends GetxController {
  static GenreController to = Get.find();
  late GenreServices _genreServices;

  // genre
  RxBool isLoadingGenre = false.obs;
  RxString errorMessageGenre = ''.obs;
  RxList<MovieGenre> genres = RxList<MovieGenre>();

  GenreController() {
    _genreServices = GenreServices();
  }

  handleListGenre() async {
    try {
      isLoadingGenre.value = true;

      Response result = await _genreServices.getListGenre();
      var jsonData = result.data;

      if (result.statusCode != 200) {
        errorMessageGenre.value = jsonData['message'];
      } else {
        List result = jsonData['genres'];
        genres.assignAll(result.map((e) => MovieGenre.fromJson(e)).toList());
      }

      isLoadingGenre.value = false;
    } catch (e) {
      isLoadingGenre.value = false;
    }
  }
}
