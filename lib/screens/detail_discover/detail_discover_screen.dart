import 'package:extramile_movie/components/app_bar_default.dart';
import 'package:extramile_movie/model/discover_model.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class DiscoverDetailScreen extends StatelessWidget {
  static String routeName = "/detail-discover";

  const DiscoverDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DiscoverDetailArguments agrs =
        ModalRoute.of(context)?.settings.arguments as DiscoverDetailArguments;
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: const AppBarWidget(title: "Back"),
      ),
      body: Body(discoverId: agrs.listDiscover.id),
    );
  }
}

class DiscoverDetailArguments {
  final MovieDiscover listDiscover;

  DiscoverDetailArguments({required this.listDiscover});
}
