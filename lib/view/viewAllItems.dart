// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expencetrackerapp/controller/globalController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import '../model/itemsModel.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/textStyle.dart';

class ViewAllItems extends StatelessWidget {
  ViewAllItems({super.key});
  final GlobalController globalController = Get.put(GlobalController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Items",
          style: appHeadingBold(28, AppColor.primaryColor),
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: Get.width - 40,
          child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('items').snapshots(),
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
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: Get.height / 5,
                    child: const Center(
                      child: CupertinoActivityIndicator(
                        color: AppColor.primaryColor,
                      ),
                    ),
                  );
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      "No Category Found",
                      style: appHeading(20, AppColor.black),
                    ),
                  );
                }
                if (snapshot.data != null) {
                  return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.85,
                              crossAxisCount: 2,
                              
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final itemsData = snapshot.data!.docs[index];
                        ItemsModel itemsModel = ItemsModel(
                            itemId: itemsData['itemId'],
                            itemName: itemsData['itemName'],
                            itemQuantity: itemsData['itemQuantity'],
                            catName: itemsData['catName'],
                            catId: itemsData['catId'],
                            itemPrice: itemsData['itemPrice'],
                            itemBuyDate: itemsData['itemBuyDate']);
                        double subTotal = 0.0;
                        subTotal =
                            (itemsModel.itemQuantity) * (itemsModel.itemPrice);
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 150,
                          decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(3, 3),
                                    blurRadius: 5,
                                    color: Colors.grey.shade400)
                              ],
                              border: const GradientBoxBorder(
                                  gradient: LinearGradient(colors: [
                                    AppColor.primaryColor,
                                    AppColor.secondaryColor,
                                    AppColor.tertiary
                                  ], transform: GradientRotation(0.785)),
                                  width: 3)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      itemsModel.itemName.toUpperCase(),
                                      style: appHeadingBold(20, AppColor.black,
                                          weight: FontWeight.w700),
                                    ),
                                    Text(
                                      itemsModel.catName.toUpperCase(),
                                      style: appHeadingBold(16, AppColor.black,
                                          weight: FontWeight.w800),
                                    ),
                                  ],
                                )),
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "\$ ${itemsModel.itemPrice.toString()} * ${itemsModel.itemQuantity}",
                                          style:
                                              appHeadingBold(18, AppColor.black),
                                        ),
                                        Text(
                                          "Sub Total \$$subTotal",
                                          style:
                                              appHeadingBold(16, AppColor.black),
                                        ),
                                        Text(
                                          itemsModel.itemBuyDate.toString(),
                                          style:
                                              appHeadingBold(14, AppColor.black),
                                        ),
                                        Align(
                                            alignment: Alignment.bottomRight,
                                            child: GestureDetector(
                                                onTap: () {
                                                  globalController.deleteItems(
                                                      itemsModel.itemId);
                                                },
                                                child: const Icon(
                                                  CupertinoIcons.delete,
                                                  size: 25,
                                                  color: AppColor.secondaryColor,
                                                )))
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        );
                      });
                }

                return const SizedBox();
              }),
        ),
      ),
    );
  }
}
