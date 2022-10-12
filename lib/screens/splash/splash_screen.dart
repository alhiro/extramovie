import 'package:extramile_movie/screens/splash/components/splash_page.dart';
import 'package:extramile_movie/size_config.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";

  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return const Scaffold(
      body: SplashPage(),
    );
  }
}
