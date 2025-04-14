import 'package:hive/hive.dart';

part "product.g.dart";

@HiveType(typeId: 0)
class Product {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final double price;
  @HiveField(4)
  final String image;
  @HiveField(5)
  final int stock;
  @HiveField(6)
  final String category;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.image,
      required this.stock,
      required this.category});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        price: (json['price'] as num).toDouble(),
        image: json['thumbnail'],
        stock: json['stock'],
        category: json['category']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'thumbnail': image,
        'stock': stock,
        'category': category
      };
}
