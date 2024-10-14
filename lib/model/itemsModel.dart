// ignore_for_file: file_names

class ItemsModel {
  final String itemId;
  final String itemName;
  final String catName;
  final String catId;
  final double itemPrice;
  final double itemQuantity;
  
  final dynamic itemBuyDate;

  ItemsModel( 
      {required this.itemId,
      required this.itemName,
      required this.itemQuantity,
      required this.catName,
      required this.catId,
      required this.itemPrice,
      required this.itemBuyDate});

  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'itemName': itemName,
      'itemQuantity':itemQuantity,
      'catName': catName,
      'catId': catId,
      'itemPrice': itemPrice,
      'itemBuyDate': itemBuyDate
    };
  }

  factory ItemsModel.fromMap(Map<String, dynamic> json) {
    return ItemsModel(
        itemId: json['itemId'],
        itemName: json['itemName'],
        itemQuantity:(json['itemQuantity'] is int) ? (json['itemQuantity'] as int).toDouble() : json['itemQuantity'],
        catName: json['catName'],
        catId: json['catId'],
        itemPrice: (json['itemPrice'] is int) ? (json['itemPrice'] as int).toDouble() : json['itemPrice'],
        itemBuyDate: json['itemBuyDate']);
  }
}
