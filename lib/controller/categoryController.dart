// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expencetrackerapp/model/categoryModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/itemsModel.dart';

class Categorycontroller extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxDouble catTotal = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    calculateAllCategoryTotals();
  }

  void calculateAllCategoryTotals() {
    firestore.collection('items').snapshots().listen((snapshot) async {
      Map<String, double> categoryTotals = {};
      Set<String> categoriesWithItems = {};

      for (var doc in snapshot.docs) {
        ItemsModel item =
            // ignore: unnecessary_cast
            ItemsModel.fromMap(doc.data() as Map<String, dynamic>);
            double itemTotal = item.itemPrice * item.itemQuantity;

        if (categoryTotals.containsKey(item.catId)) {
          categoryTotals[item.catId] = categoryTotals[item.catId]! + itemTotal;
        } else {
          categoryTotals[item.catId] = itemTotal;
        }
        categoriesWithItems.add(item.catId);
      }

      var categorySnapshot = await firestore.collection('category').get();

      for (var catDoc in categorySnapshot.docs) {
        String catId = catDoc.id;


        if (categoriesWithItems.contains(catId)) {
          double totalPrice = categoryTotals[catId] ?? 0.0;
          await firestore.collection('category').doc(catId).update({
            'catTotals': totalPrice,
          });
        }

        else {
          await firestore.collection('category').doc(catId).update({
            'catTotals': 0.0,
          });
        }
      }
      // // Optional: Print total per category for debugging
      // categoryTotals.forEach((catId, totalPrice) {
      //   print('Category ID: $catId, Total Price: $totalPrice');
      // });
    });
  }

  Future<void> addCategory(String catId, String catName, String catImage,
      double catTotals, dynamic createAt) async {
    Categorymodel catModel = Categorymodel(
        catId: catId,
        catName: catName.toLowerCase(),
        catImage: catImage,
        catTotals: catTotals,
        createAt: createAt);
    var isExist = await firestore
        .collection('category')
        .where('catName', isEqualTo: catName.toLowerCase())
        .get();
    try {
      if (isExist.docs.isEmpty) {
        await firestore.collection('category').doc(catId).set(catModel.toMap());
        Get.snackbar(
          'Success',
          "Category Added",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.black,
        );
      } else {
        Get.snackbar(
          'Error',
          "Category Already Exist",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.black,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        "$e",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
