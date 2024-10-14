import 'package:expencetrackerapp/controller/bardataController.dart';
import 'package:expencetrackerapp/controller/globalController.dart'; // Import GlobalController
import 'package:expencetrackerapp/view/barChart/barGraph.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/header.dart';

class StatsScreen extends StatelessWidget {
  StatsScreen({super.key});
  final Bardatacontroller bardatacontroller = Get.put(Bardatacontroller());
  final GlobalController globalController = Get.put(GlobalController()); // Initialize GlobalController

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(children: [
          header(),
          const SizedBox(height: 50),
          Obx(() {
            if (bardatacontroller.barData.isEmpty) {
              return const CircularProgressIndicator();
            }
            return SizedBox(
              height: Get.width,
              child: MyBarGraph(
                barData: bardatacontroller.barData,
                totalBalance: globalController.totalBalance.value, // Use totalBalance
                categoryNames: bardatacontroller.categories.map((e) => e.catName).toList(), // Pass category names
              ),
            );
          }),
        ]),
      ),
    );
  }
}
