import '../view/addItemsScreen.dart';
import '../view/stats.dart';
import 'package:get/get.dart';

import '../view/mainScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/constants/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BottomNavigationBar(
            backgroundColor: Colors.white,
            elevation: 3,
            onTap: (value) {
              setState(() {
                index = value;
              });
            },
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home,color: index==0?AppColor.primaryColor:AppColor.black,), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.chart_bar_alt_fill,color: index==1?AppColor.primaryColor:AppColor.black,),
                  label: 'Stats'),
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.large(
        heroTag: null,
        shape: const CircleBorder(),
        elevation: 20,
        onPressed: () {
          Get.to(const AddItemScreen());
        },
        child: Hero(
          tag: 'add',
          child: Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    AppColor.secondaryColor,
                    AppColor.tertiary,
                    AppColor.primaryColor
                  ], transform: GradientRotation(0.785))),
              child: const Icon(
                CupertinoIcons.add,
                color: AppColor.black,
              )),
        ),
      ),
      body: index==0?MainScreen():StatsScreen(),
    );
  }
}
