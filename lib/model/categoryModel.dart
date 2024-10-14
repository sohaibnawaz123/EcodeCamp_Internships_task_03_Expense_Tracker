// ignore_for_file: file_names

class Categorymodel {
  final String catId;
  final String catName;
  final String catImage;
  final double catTotals;
  final dynamic createAt;

  Categorymodel(
      {required this.catId,
      required this.catName,
      required this.catImage,
      required this.catTotals,
      required this.createAt});

  Map<String, dynamic> toMap() {
    return {
      "catId": catId,
      "catName": catName,
      "catImage": catImage,
      "catTotals": catTotals,
      "createAt": createAt
    };
  }

  factory Categorymodel.fromMap(Map<String, dynamic> json) {
    return Categorymodel(
        catId: json['catId'],
        catName: json['catName'],
        catImage: json['catImage'],
        catTotals: json['catTotals'],
        createAt: json['createAt']);
  }
}
