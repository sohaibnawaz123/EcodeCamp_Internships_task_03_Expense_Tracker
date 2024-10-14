// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import '../controller/categoryController.dart';
import 'package:flutter/material.dart';
import '../model/itemsModel.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Categorycontroller categorycontroller = Get.put(Categorycontroller());
  final RxDouble totalBalance = 100000.0.obs;
  final RxDouble totalExpence = 0.0.obs;
  final RxDouble totalIncome = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchItemsPrice();
  }

  Future<void> addItem(
      String catId,
      String itemId,
      String catName,
      String itemName,
      double itemPrice,
      double itemQuantity,
      dynamic itemBuyDate) async {
    try {
      ItemsModel itemModel = ItemsModel(
          itemId: itemId,
          itemName: itemName.toLowerCase(),
          itemQuantity: itemQuantity,
          catName: catName.toLowerCase(),
          catId: catId,
          itemPrice: itemPrice,
          itemBuyDate: itemBuyDate);

      await firestore.collection('items').doc(itemId).set(itemModel.toMap());

      Get.snackbar(
        'Success',
        "Item Added",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.black,
      );
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

  Future<void> deleteItems(String itemId) async {
    try {
      await firestore.collection('items').doc(itemId).delete();
      categorycontroller.calculateAllCategoryTotals();
      Get.snackbar(
        'Success',
        "Item Deleted",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.black,
      );
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

  void fetchItemsPrice() async {
    firestore.collection('items').snapshots().listen((snapshot) {
      double sum = 0.0;
      for (final doc in snapshot.docs) {
        final data = doc.data();
        if (data.containsKey('itemPrice')) {
          sum += ((data['itemPrice'] as num) * (data['itemQuantity'] as num))
              .toDouble();
        }
      }
      totalExpence.value = sum;
      totalIncome.value = totalBalance.value - totalExpence.value;
    });
  }
}
