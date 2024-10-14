import 'package:expencetrackerapp/controller/globalController.dart';

import 'constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants/textStyle.dart';

class Debitcard extends StatelessWidget {
  const Debitcard({super.key});

  @override
  Widget build(BuildContext context) {
  final GlobalController globalController = Get.put(GlobalController());
  
  return Container(
    width: Get.width,
    height: Get.width / 2,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade500,
              blurRadius: 4,
              offset: const Offset(4, 4))
        ],
        gradient: const LinearGradient(colors: [
          AppColor.primaryColor,
          AppColor.secondaryColor,
          AppColor.tertiary
        ], transform: GradientRotation(0.785))),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              'Total Balance',
              style: appHeading(18, AppColor.white, weight: FontWeight.w700),
            ),
            Obx(() => Text(
              '\$ ${globalController.totalBalance.value}',
              style: appHeading(40, AppColor.white, weight: FontWeight.w900),
            ))
          ],
        ),
        SizedBox(
          height: Get.width / 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.black26,
                    radius: 20,
                    child: Icon(
                      CupertinoIcons.arrowtriangle_up_fill,
                      color: Colors.green,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => Text(
                        "\$ ${globalController.totalIncome.value.toString()}",
                        style: appHeading(18, AppColor.white, weight: FontWeight.w900),
                      )),
                      Text(
                        'Income',
                        style: appHeading(16, AppColor.white, weight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.black26,
                    radius: 20,
                    child: Icon(
                      CupertinoIcons.arrowtriangle_down_fill,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => Text(
                        '\$ ${globalController.totalExpence.value.toString()}',
                        style: appHeading(18, AppColor.white, weight: FontWeight.w900),
                      )),
                      Text(
                        'Expense',
                        style: appHeading(16, AppColor.white, weight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
  }
}