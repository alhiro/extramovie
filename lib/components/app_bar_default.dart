import 'package:extramile_movie/constants.dart';
import 'package:extramile_movie/size_config.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarWidget({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.wildSand),
          iconSize: 16,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: getProportionateScreenWidth(14),
          color: Colors.white,
        ),
      ),
      centerTitle: false,
      backgroundColor: AppColors.ebonyClay,
    );
  }
}
