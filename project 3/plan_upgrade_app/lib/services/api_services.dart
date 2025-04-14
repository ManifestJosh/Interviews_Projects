import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static Future<List<Product>> getProducts() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products?limit=50'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final productsJson = jsonData['products'] as List;
      return productsJson.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
