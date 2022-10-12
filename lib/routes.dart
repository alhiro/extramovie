import 'package:extramile_movie/screens/detail_discover/detail_discover_screen.dart';
import 'package:extramile_movie/screens/discover/discover_screen.dart';
import 'package:extramile_movie/screens/home/home_screen.dart';
import 'package:extramile_movie/screens/splash/splash_screen.dart';
import 'package:flutter/widgets.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  DiscoverScreen.routeName: (context) => const DiscoverScreen(),
  DiscoverDetailScreen.routeName: (context) => const DiscoverDetailScreen(),
};
