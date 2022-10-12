import 'package:extramile_movie/constants.dart';
import 'package:extramile_movie/size_config.dart';
import 'package:flutter/material.dart';

import 'genre.dart';
import 'home_header.dart';

class Body extends StatefulWidget {
  const Body({super.key});

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
      height: MediaQuery.of(context).size.height,
      color: AppColors.ebonyClay,
      child: RefreshIndicator(
        onRefresh: refreshData,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(20)),
                const HomeHeader(),
                SizedBox(height: getProportionateScreenWidth(10)),
                const GetGenre(),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Future refreshData() async {}
}
