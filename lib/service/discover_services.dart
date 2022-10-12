import 'package:dio/dio.dart';
import 'package:extramile_movie/secret/the_moviedb_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:extramile_movie/secret/the_moviedb_api.dart' as secret;

class DiscoverServices {
  final baseUrl = dotenv.env['API_URL'];

  Future<dynamic> getListDiscoverByGenre(genreId, page) async {
    try {
      Map<String, String> requestHeaders = {
        'Authorization': themoviedbBearer,
      };
      String url =
          '$baseUrl/discover/movie?api_key=${secret.themoviedbApi}&with_genres=$genreId&page=$page';
      print(url);

      var dio = Dio();

      var response =
          await dio.get(url, options: Options(headers: requestHeaders));

      return response;
    } on DioError catch (e) {
      throw Exception(e.response!.data);
    }
  }

  Future<dynamic> getDetailDiscoverByGenre(movieId) async {
    try {
      Map<String, String> requestHeaders = {
        'Authorization': themoviedbBearer,
      };
      String url = '$baseUrl/movie/$movieId?api_key=${secret.themoviedbApi}';

      var dio = Dio();

      var response =
          await dio.get(url, options: Options(headers: requestHeaders));

      return response;
    } on DioError catch (e) {
      throw Exception(e.response!.data);
    }
  }
}
