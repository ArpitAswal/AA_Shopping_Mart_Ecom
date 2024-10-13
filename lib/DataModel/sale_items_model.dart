import 'Rating.dart';

class SaleItemsModel {
  SaleItemsModel({
    this.discount,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  SaleItemsModel.fromJson(dynamic json) {
    discount = json['discount'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
  }
  double? discount;
  String? title;
  double? price;
  String? description;
  String? category;
  List<String>? image;
  Rating? rating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['discount'] = discount;
    map['title'] = title;
    map['price'] = price;
    map['description'] = description;
    map['category'] = category;
    map['image'] = image;
    if (rating != null) {
      map['rating'] = rating?.toJson();
    }
    return map;
  }
}
