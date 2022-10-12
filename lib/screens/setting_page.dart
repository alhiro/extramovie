// ignore_for_file: unnecessary_const

import 'package:extramile_movie/components/coustom_bottom_nav_bar.dart';
import 'package:extramile_movie/constants.dart';
import 'package:extramile_movie/enums.dart';
import 'package:extramile_movie/size_config.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: AppColors.ebony,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[_buildTitle()],
              ),
            ],
          )),
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.info),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 0),
          child: Container(
            margin: const EdgeInsets.only(top: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                Text(
                  "ExtraMile Movie",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                  ),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
          child: Container(
            margin: const EdgeInsets.only(top: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Column(
                      children: [
                        _buildVersion(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVersion() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(getProportionateScreenWidth(0)),
          child: const InkWell(
            child: const Text('v1.0.0',
                style: const TextStyle(color: Colors.white, fontSize: 11)),
          ),
        ),
      ],
    );
  }
}
