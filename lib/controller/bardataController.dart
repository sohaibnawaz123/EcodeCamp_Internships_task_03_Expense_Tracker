import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:expencetrackerapp/model/categoryModel.dart';
import 'package:expencetrackerapp/model/barModel.dart';

class Bardatacontroller extends GetxController {
  RxList<Categorymodel> categories = RxList<Categorymodel>();
  RxList<IndividualBar> barData = RxList<IndividualBar>();

  @override
  void onInit() {
    super.onInit();
    listenToCategories();
  }

  // Listen to changes in the 'category' collection in Firestore
  void listenToCategories() {
    FirebaseFirestore.instance
        .collection('category')
        .snapshots()
        .listen((snapshot) {
      List<Categorymodel> updatedCategories = [];
      
      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        Categorymodel category = Categorymodel.fromMap(data);
        updatedCategories.add(category);
      }

      // Update categories list
      categories.value = updatedCategories;

      // Reflect the changes in the barData
      updateBarData();
    });
  }

  void updateBarData() {
    barData.value = categories.asMap().entries.map((entry) {
      int index = entry.key;
      Categorymodel category = entry.value;
      return IndividualBar(x: index, y: category.catTotals);
    }).toList();
  }
}
