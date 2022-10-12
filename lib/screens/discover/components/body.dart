import 'package:extramile_movie/constants.dart';
import 'package:extramile_movie/size_config.dart';
import 'package:flutter/material.dart';

import 'discover.dart';

class Body extends StatefulWidget {
  final int? genreId;

  const Body({super.key, required this.genreId});

  @override
  // ignore: library_private_types_in_public_api
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  loadData() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: AppColors.ebonyClay,
      child: RefreshIndicator(
        onRefresh: refreshData,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                GetDiscover(genreId: widget.genreId),
                SizedBox(height: getProportionateScreenHeight(11)),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Future refreshData() async {}
}
