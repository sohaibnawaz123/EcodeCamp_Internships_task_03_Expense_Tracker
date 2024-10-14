// ignore_for_file: file_names
import 'package:expencetrackerapp/controller/categoryController.dart';
import 'package:expencetrackerapp/utils/constants/textStyle.dart';
import 'package:expencetrackerapp/utils/customTextFeild.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';

import 'constants/colors.dart';

class Addcategorywidget extends StatefulWidget {
  const Addcategorywidget({super.key});

  @override
  State<Addcategorywidget> createState() => _AddcategorywidgetState();
}

class _AddcategorywidgetState extends State<Addcategorywidget> {
  final Categorycontroller categorycontroller = Get.put(Categorycontroller());
  final TextEditingController catName = TextEditingController();
  final TextEditingController catIcon = TextEditingController();
  bool isCatNameExpended = false;
  bool isCatIconExpended = false;
  String icon = '';
  List<String> categoryName = [
    'Entertainment',
    'Grocery',
    'Home',
    'Technology',
    'Pets',
    'Shopping',
    'Travel',
    'Health Care'
  ];
  List<String> categoryIcon = [
    'entertainment',
    'grocery',
    'home',
    'technology',
    'pets',
    'shopping-basket',
    'travel',
    'healthcare'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: isCatNameExpended || isCatIconExpended
          ? Get.width + 100
          : Get.width - 100,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: const GradientBoxBorder(
              gradient: LinearGradient(colors: [
                AppColor.primaryColor,
                AppColor.secondaryColor,
                AppColor.tertiary
              ], transform: GradientRotation(0.785)),
              width: 3)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Add Category',
                style: appHeadingBold(28, AppColor.primaryColor),
              ),
              const SizedBox(
                height: 20,
              ),
              customTextFeild(
                catName,
                'Category Name',
                readOnly: true,
                sufixIcon: const Icon(
                  CupertinoIcons.arrowtriangle_down_fill,
                  color: AppColor.primaryColor,
                ),
                onTap: () {
                  setState(() {
                    isCatNameExpended = !isCatNameExpended;
                    isCatIconExpended = false;
                  });
                },
              ),
              isCatNameExpended
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: const GradientBoxBorder(
                              gradient: LinearGradient(colors: [
                                AppColor.primaryColor,
                                AppColor.secondaryColor,
                                AppColor.tertiary
                              ], transform: GradientRotation(0.785)),
                              width: 3)),
                      child: ListView.builder(
                          itemCount: categoryName.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      catName.text = categoryName[index];
                                      isCatNameExpended = false;
                                    });
                                  },
                                  child: Text(
                                    categoryName[index],
                                    style: appHeading(18, AppColor.black,
                                        weight: FontWeight.w900),
                                  )),
                            );
                          }),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(
                height: 30,
              ),
              customTextFeild(
                catIcon,
                'Category Icon',
                readOnly: true,
                prefixIcon: icon.isEmpty
                    ? const Icon(
                        CupertinoIcons.globe,
                        color: AppColor.primaryColor,
                        size: 30,
                      )
                    : Image.asset(
                        'assets/icons/$icon.png',
                        width: 30,
                        height: 30,
                        fit: BoxFit.contain,
                      ),
                sufixIcon: const Icon(
                  CupertinoIcons.arrowtriangle_down_fill,
                  color: AppColor.primaryColor,
                ),
                onTap: () {
                  setState(() {
                    isCatIconExpended = !isCatIconExpended;
                    isCatNameExpended = false;
                  });
                },
              ),
              isCatIconExpended
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: const GradientBoxBorder(
                              gradient: LinearGradient(colors: [
                                AppColor.primaryColor,
                                AppColor.secondaryColor,
                                AppColor.tertiary
                              ], transform: GradientRotation(0.785)),
                              width: 3)),
                      child: ListView.builder(
                          itemCount: categoryIcon.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      catIcon.text = categoryIcon[index];
                                      isCatIconExpended = false;
                                      icon = categoryIcon[index];
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/icons/${categoryIcon[index]}.png',
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.contain,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        categoryIcon[index].toLowerCase(),
                                        style: appHeading(18, AppColor.black,
                                            weight: FontWeight.w900),
                                      ),
                                    ],
                                  )),
                            );
                          }),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: Get.width,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(5, 5),
                      color: Colors.grey.shade400,
                      blurRadius: 5)
                ],
                gradient: const LinearGradient(colors: [
                  AppColor.tertiary,
                  AppColor.secondaryColor,
                  AppColor.primaryColor,
                ], transform: GradientRotation(0.785))),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, elevation: 0),
                onPressed: () {
                  String catNameVar = catName.text;
                  String catIconVar = catIcon.text.toLowerCase();
                  String catId = randomAlphaNumeric(10);
                  dynamic createAt =
                      DateFormat('dd/MM/yyyy').format(DateTime.now());
                  double catTotals = 0;
                  if (catNameVar.isNotEmpty && catIconVar.isNotEmpty) {
                    categorycontroller.addCategory(
                        catId, catNameVar, catIconVar, catTotals, createAt);
                    catName.clear();
                    catIcon.clear();
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Save Category',
                  style: appHeadingBold(24, AppColor.white),
                )),
          )
        ],
      ),
    );
  }
}
