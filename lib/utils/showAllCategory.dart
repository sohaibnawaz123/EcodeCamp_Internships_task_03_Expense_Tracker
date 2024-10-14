// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controller/categoryController.dart';
import '../model/categoryModel.dart';
import '../view/allCategoryItems.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import '../utils/constants/textStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'constants/colors.dart';

class ShowAllCategory extends StatelessWidget {
  ShowAllCategory({super.key});
  final Categorycontroller categorycontroller = Get.put(Categorycontroller());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('category').orderBy('catName').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final catData = snapshot.data!.docs[index];
                    Categorymodel catModel = Categorymodel(
                        catId: catData['catId'],
                        catName: catData['catName'],
                        catImage: catData['catImage'],
                        catTotals: catData['catTotals'],
                        createAt: catData['createAt']);
                    return GestureDetector(
                      onTap: () => Get.to(AllCategoryItems(catId: catModel.catId,catName: catModel.catName,catImage: catModel.catImage,)),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppColor.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(3, 3),
                                blurRadius: 5,
                                color: Colors.grey.shade400
                              )
                            ],
                            border: const GradientBoxBorder(
                                gradient: LinearGradient(colors: [
                                  AppColor.primaryColor,
                                  AppColor.secondaryColor,
                                  AppColor.tertiary
                                ], transform: GradientRotation(0.785)),
                                width: 3)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                                child: Hero(
                                  tag: catModel.catId,
                                  transitionOnUserGestures: true,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset("assets/icons/${catModel.catImage}.png"
                                        ,
                                        fit: BoxFit.contain,
                                        width: 50,
                                        height: 50,
                                        
                                      )),
                                )),
                            Expanded(flex: 2,child: Text(catModel.catName.toUpperCase(),style: appHeadingBold(18, AppColor.black),)),
                            Expanded(flex: 1,child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("\$ ${catModel.catTotals.toString()}",style: appHeadingBold(16, AppColor.black),),
                                Text(catModel.createAt.toString(),style: appHeadingBold(14, AppColor.black),),
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
    );
  }
}
