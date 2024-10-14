// ignore_for_file: file_names

import 'package:expencetrackerapp/controller/globalController.dart';
import 'package:expencetrackerapp/utils/showAllCategory.dart';
import 'package:expencetrackerapp/view/viewAllItems.dart';
import '../utils/debitcard.dart';
import 'package:expencetrackerapp/utils/header.dart';
import 'package:expencetrackerapp/utils/constants/textStyle.dart';
import '../utils/constants/colors.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final GlobalController globalController = Get.put(GlobalController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          header(),
          SizedBox(
            height: Get.width / 20,
          ),
          const Debitcard(),
          SizedBox(
            height: Get.width / 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Transactions',
                style:
                    appHeadingBold(28, AppColor.black, weight: FontWeight.w700),
              ),
              GestureDetector(
                onTap: () => Get.to(ViewAllItems()),
                child: Text(
                  'View All',
                  style: appHeading(20, Colors.black54, weight: FontWeight.w900),
                ),
              )
            ],
          ),
          Expanded(child: ShowAllCategory())
        ],
      ),
    ));
  }
}
