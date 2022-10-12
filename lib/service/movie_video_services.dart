import 'package:dio/dio.dart';
import 'package:extramile_movie/secret/the_moviedb_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:extramile_movie/secret/the_moviedb_api.dart' as secret;

class MovieVideoServices {
  final baseUrl = dotenv.env['API_URL'];

  Future<dynamic> getMovieVideo(movieId) async {
    try {
      Map<String, String> requestHeaders = {
        'Authorization': themoviedbBearer,
      };
      String url =
          '$baseUrl/movie/$movieId/videos?api_key=${secret.themoviedbApi}';
      var dio = Dio();

      var response =
          await dio.get(url, options: Options(headers: requestHeaders));

      return response;
    } on DioError catch (e) {
      throw Exception(e.response!.data);
    }
  }
}
