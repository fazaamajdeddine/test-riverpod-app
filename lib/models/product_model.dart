import 'package:tutoriverpod/models/rating_model.dart';

class Product {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;

  Product(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.image,
      this.rating});

 factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
    id : json['id'],
    title : json['title'],
    price : json['price'] is double ? json['price'] : (json['price'] as int).toDouble(),
    description : json['description'],
    category : json['category'],
    image : json['image'],
    rating :
        json['rating'] != null ?  Rating.fromJson(json['rating']) : null,);
  }
}


