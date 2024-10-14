// ignore_for_file: file_names, must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import '../controller/globalController.dart';
import '../model/categoryModel.dart';
import '../utils/addCategoryWidget.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/textStyle.dart';
import '../utils/customTextFeild.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  TextEditingController itemNameController = TextEditingController();

  TextEditingController catNameController = TextEditingController();

  TextEditingController itemPriceController = TextEditingController();

  TextEditingController itemBuyDateController = TextEditingController();

  TextEditingController itemQuantityController = TextEditingController();
  bool isExtended = false;
  double quantity = 1;
  String globalCatId = '';
  String catIcon = '';
  DateTime selectedDate = DateTime.now();
  final GlobalController globalController = Get.put(GlobalController());
  @override
  void initState() {
    super.initState();
    itemQuantityController.text = '1.0';
    itemBuyDateController.text =
        DateFormat("dd/MM/yyyy").format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                tooltip: "Add Category",
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (contextAlert) {
                        return const AlertDialog(
                          contentPadding: EdgeInsets.all(0),
                          content: Addcategorywidget(),
                        );
                      });
                },
                icon: const Icon(
                  CupertinoIcons.add_circled,
                  size: 35,
                )),
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black26,
                boxShadow: [
                  BoxShadow(
                      color: Colors.white12,
                      offset: Offset(2, 2),
                      blurRadius: 10)
                ]),
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  CupertinoIcons.arrowtriangle_left_fill,
                  color: AppColor.black,
                )),
          ),
        ),
        toolbarHeight: 80,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade500,
                    blurRadius: 4,
                    offset: const Offset(0, 4))
              ],
              gradient: const LinearGradient(colors: [
                AppColor.primaryColor,
                AppColor.secondaryColor,
                AppColor.tertiary
              ], transform: GradientRotation(0.785))),
        ),
        title: Text(
          'ADD ITEM',
          style: appHeadingBold(
            36,
            AppColor.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                customTextFeild(itemNameController, 'Item Name',
                    keyboard: TextInputType.text),
                const SizedBox(
                  height: 30,
                ),
                customTextFeild(catNameController, 'Category Name',
                    keyboard: TextInputType.text, onTap: () {
                  setState(() {
                    isExtended = !isExtended;
                  });
                },
                    sufixIcon: const Icon(
                      CupertinoIcons.arrowtriangle_down_fill,
                      color: AppColor.primaryColor,
                    ),
                    prefixIcon: catIcon.isEmpty
                        ? const Icon(CupertinoIcons.globe,color: AppColor.primaryColor,size: 30,)
                        : Image.asset(
                            'assets/icons/$catIcon.png',width: 40,height: 30,fit: BoxFit.contain,),
                    readOnly: true),
                const SizedBox(
                  height: 10,
                ),
                isExtended
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
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("category")
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text(
                                    "Error",
                                    style: appHeading(20, AppColor.black),
                                  ),
                                );
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return SizedBox(
                                  height: Get.height / 5,
                                  child: const Center(
                                    child: CupertinoActivityIndicator(
                                      color: AppColor.secondaryColor,
                                    ),
                                  ),
                                );
                              }
                              if (snapshot.data!.docs.isEmpty) {
                                return Center(
                                  child: Text(
                                    "No Category Found",
                                    style: appHeading(20, AppColor.tertiary),
                                  ),
                                );
                              }
                              if (snapshot.data != null) {
                                return ListView.builder(
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      final catData =
                                          snapshot.data!.docs[index];
                                      Categorymodel catModel = Categorymodel(
                                          catId: catData['catId'],
                                          catName: catData['catName'],
                                          catImage: catData['catImage'],
                                          catTotals: catData['catTotals'],
                                          createAt: catData['createAt']);
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            catNameController.text =
                                                catModel.catName.toUpperCase();
                                            isExtended = false;
                                            catIcon = catModel.catImage;
                                            globalCatId = catModel.catId;
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Text(
                                            catModel.catName.toUpperCase(),
                                            style: appHeading(
                                                18, AppColor.black,
                                                weight: FontWeight.w900),
                                          ),
                                        ),
                                      );
                                    });
                              }
                              return const SizedBox();
                            }),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: customTextFeild(itemPriceController, 'Item Amount',
                          keyboard: TextInputType.number),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: customTextFeild(
                        itemQuantityController,
                        textalign: TextAlign.center,
                        'Item Quantity',
                        keyboard: TextInputType.number,
                        prefixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              quantity++;
                              itemQuantityController.text = quantity.toString();
                            });
                          },
                          child: Container(
                              height: 30,
                              width: 30,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(colors: [
                                    AppColor.tertiary,
                                    AppColor.secondaryColor,
                                    AppColor.primaryColor,
                                  ], transform: GradientRotation(0.785))),
                              child: const Icon(
                                CupertinoIcons.add,
                                color: AppColor.white,
                              )),
                        ),
                        sufixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              quantity--;
                              if (quantity == 0) {
                                quantity = 1;
                              }
                              itemQuantityController.text = quantity.toString();
                            });
                          },
                          child: Container(
                              height: 30,
                              width: 30,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(colors: [
                                    AppColor.tertiary,
                                    AppColor.secondaryColor,
                                    AppColor.primaryColor,
                                  ], transform: GradientRotation(0.785))),
                              child: const Icon(
                                CupertinoIcons.minus,
                                color: AppColor.white,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                customTextFeild(
                  itemBuyDateController,
                  'Item Buy Date',
                  readOnly: true,
                  onTap: () async {
                    DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2024),
                        lastDate: DateTime(2050));

                    if (newDate != null) {
                      setState(() {
                        itemBuyDateController.text =
                            DateFormat('dd/MM/yyyy').format(newDate);
                        selectedDate = newDate;
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Hero(
                  tag: 'add',
                  child: Container(
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
                          String itemName = itemNameController.text;
                          String catName = catNameController.text;
                          double itemPrice =
                              double.parse(itemPriceController.text);
                          double itemQuantity =
                              double.parse(itemQuantityController.text);
                          if (itemName.isNotEmpty &&
                              catName.isNotEmpty &&
                              itemPrice != 0 &&
                              itemQuantity != 0) {
                            String itemId = randomAlphaNumeric(10);
                            globalController.addItem(
                                globalCatId,
                                itemId,
                                catName,
                                itemName,
                                itemPrice,
                                itemQuantity,
                                itemBuyDateController.text);
                          } else {
                            Get.snackbar('Error', 'Please Fill The Fields',
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                          }
                          itemNameController.clear();
                          catNameController.clear();
                          setState(() {
                            itemPriceController.text = '1';
                            itemQuantityController.text = '1.0';
                          });
                          Get.back();
                        },
                        child: Text(
                          'Save Item',
                          style: appHeadingBold(28, AppColor.white),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
