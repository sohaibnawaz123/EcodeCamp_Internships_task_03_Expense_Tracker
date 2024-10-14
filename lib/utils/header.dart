import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants/colors.dart';
import 'iconBox.dart';
import 'constants/textStyle.dart';

Widget header() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      IconBox(
        title: 'Sohaib Nawaz',
        subtitle: 'Welcome!',
        icon: Icon(
          CupertinoIcons.person_fill,
          color: Colors.yellow.shade600,
          size: 30,
        ),
        iconBg: AppColor.tertiary,
        titleStyle: appHeading(20, AppColor.black, weight: FontWeight.w900),
        subtitleStyle: appHeading(16, AppColor.black, weight: FontWeight.w600),
        wantIcon: true,
        iconSize: 30,
      ),
      const IconButton(
          onPressed: null,
          icon: Icon(
            CupertinoIcons.settings_solid,
            size: 40,
            color: AppColor.black,
          ))
    ],
  );
}
