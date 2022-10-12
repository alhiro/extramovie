import 'package:extramile_movie/components/app_bar_default.dart';
import 'package:extramile_movie/model/genre_model.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class DiscoverScreen extends StatelessWidget {
  static String routeName = "/discover";

  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DiscoverArguments agrs =
        ModalRoute.of(context)?.settings.arguments as DiscoverArguments;
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: const AppBarWidget(title: "Back"),
      ),
      body: Body(genreId: agrs.listGenre.id),
    );
  }
}

class DiscoverArguments {
  final MovieGenre listGenre;

  DiscoverArguments({required this.listGenre});
}
