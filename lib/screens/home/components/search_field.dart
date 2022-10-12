import 'package:flutter/material.dart';

import '../../../../../constants.dart';
import '../../../../../size_config.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.75,
      decoration: BoxDecoration(
        color: kPrimaryLightColor.withOpacity(1),
        borderRadius: BorderRadius.circular(11),
      ),
      child: TextField(
        onChanged: (value) => {},
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenWidth(14)),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Search Movie...",
            prefixIcon: const Icon(Icons.search)),
      ),
    );
  }
}
