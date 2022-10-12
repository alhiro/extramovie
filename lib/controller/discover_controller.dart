import 'package:dio/dio.dart';
import 'package:extramile_movie/model/detail_discover_model.dart';
import 'package:extramile_movie/model/discover_model.dart';
import 'package:extramile_movie/service/discover_services.dart';
import 'package:get/get.dart' hide Response;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DiscoverController extends GetxController {
  static DiscoverController to = Get.find();
  late DiscoverServices _discoverServices;

  // discover
  RxBool isLoadingDiscoverGenre = false.obs;
  RxString errorMessageDiscoverGenre = ''.obs;
  RxList<MovieDiscover> discoversGenre = RxList<MovieDiscover>();

  // detail discover
  RxBool isLoadingDetailDiscoverGenre = false.obs;
  RxString errorMessageDetailDiscoverGenre = ''.obs;
  Rxn<MovieDetailDiscover> detailDiscoverGenre = Rxn<MovieDetailDiscover>();

  DiscoverController() {
    _discoverServices = DiscoverServices();
  }

  int currentPage = 1;
  int page = 1;
  int? totalPages;
  int? totalItem;

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  handleGetDiscoverByGenre(int? genreId, int? page) async {
    try {
      isLoadingDiscoverGenre.value = true;
      Response result =
          await _discoverServices.getListDiscoverByGenre(genreId, page);
      var jsonData = result.data;

      if (result.statusCode != 200) {
        errorMessageDiscoverGenre.value = jsonData['message'];
      } else {
        List result = jsonData['results'];
        discoversGenre
            .assignAll(result.map((e) => MovieDiscover.fromJson(e)).toList());
      }

      isLoadingDiscoverGenre.value = false;
    } catch (e) {
      isLoadingDiscoverGenre.value = false;
    }
  }

  handleGetDiscoverByGenreEndless(
      int? genreId, int page, bool isRefresh) async {
    try {
      isLoadingDiscoverGenre.value = true;
      Response result =
          await _discoverServices.getListDiscoverByGenre(genreId, page);
      var jsonData = result.data;

      if (result.statusCode != 200) {
        errorMessageDiscoverGenre.value = jsonData['message'];
      } else {
        totalPages = jsonData["total_pages"];

        if (page == totalPages) {
          refreshController.loadComplete();
          return true;
        } else {
          List result = jsonData['results'];
          discoversGenre
              .assignAll(result.map((e) => MovieDiscover.fromJson(e)).toList());
        }
      }

      isLoadingDiscoverGenre.value = false;

      return true;
    } catch (e) {
      isLoadingDiscoverGenre.value = false;
    }
  }

  handleGetDetailDiscoverByGenre(int? movieId) async {
    try {
      isLoadingDetailDiscoverGenre.value = true;
      Response result =
          await _discoverServices.getDetailDiscoverByGenre(movieId);
      var jsonData = result.data;

      if (result.statusCode != 200) {
        errorMessageDetailDiscoverGenre.value = jsonData['message'];
      } else {
        detailDiscoverGenre.value = MovieDetailDiscover.fromJson(jsonData);
      }

      isLoadingDetailDiscoverGenre.value = false;
    } catch (e) {
      isLoadingDetailDiscoverGenre.value = false;
    }
  }
}
