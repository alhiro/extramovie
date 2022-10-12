import 'package:extramile_movie/controller/discover_controller.dart';
import 'package:extramile_movie/controller/genre_controller.dart';
import 'package:extramile_movie/controller/movie_video_controller.dart';
import 'package:extramile_movie/controller/review_user_controller.dart';
import 'package:extramile_movie/routes.dart';
import 'package:extramile_movie/screens/splash/splash_screen.dart';
import 'package:extramile_movie/theme.dart';
import 'package:extramile_movie/utils/env_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  await loadEnvFile("assets/env/.env_production");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String title = 'ExtraMile Movie';

  final GenreController genreController =
      Get.put<GenreController>(GenreController());
  final DiscoverController discoverController =
      Get.put<DiscoverController>(DiscoverController());
  final ReviewUserController reviewUserController =
      Get.put<ReviewUserController>(ReviewUserController());
  final MovieVideoController movieVideoController =
      Get.put<MovieVideoController>(MovieVideoController());
  MyApp({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: theme(),
        initialRoute: SplashScreen.routeName,
        routes: routes,
      );
}
