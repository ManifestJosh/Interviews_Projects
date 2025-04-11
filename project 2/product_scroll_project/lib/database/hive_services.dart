import 'package:hive/hive.dart';
import 'package:product_scroll_project/models/product.dart';

class HiveService {
  static Future<void> init() async {
    if (!Hive.isBoxOpen('products')) {
      await Hive.openBox<Product>('products');
    }
    if (!Hive.isBoxOpen('search_keywords')) {
      await Hive.openBox('search_keywords');
    }
  }

  static Future<void> cacheProducts(List<Product> products) async {
    final box = Hive.box<Product>('products');
    await box.clear();
    await box.addAll(products);
  }

  static List<Product> getCachedProducts() {
    final box = Hive.box<Product>('products');
    return box.values.toList();
  }

  static Future<void> saveSearchKeyword(String keyword) async {
    final box = Hive.box('search_keywords');
    List<String> keywords =
        box.get('keywords', defaultValue: <String>[])!.cast<String>();
    if (!keywords.contains(keyword)) {
      keywords.add(keyword);
      if (keywords.length > 10) keywords.removeAt(0);
      await box.put('keywords', keywords);
    }
  }

  static List<String> getSearchKeywords() {
    final box = Hive.box('search_keywords');
    return box.get('keywords', defaultValue: <String>[])!.cast<String>();
  }
}
