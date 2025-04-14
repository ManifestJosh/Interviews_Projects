import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../database/hive_services.dart';
import '../models/product.dart';
import '../services/api_services.dart';

class ProductController extends GetxController {
  var allProducts = <Product>[];
  var displayedProducts = <Product>[].obs;
  var cart = <Product, int>{}.obs;
  var suggestions = <Product>[].obs;
  var searchQuery = ''.obs;
  var keywordSuggestions = <String>[].obs;
  var isLoading = false.obs;
  var isLastPage = false.obs;
  var currentPage = 1;
  final int pageSize = 10;

  var userPlan = 'Free'.obs;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    fetchProducts();
    setupScrollListener();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      final fetched = await ApiService.getProducts();
      allProducts = fetched;
      applyFilters();
    } finally {
      isLoading.value = false;
    }
  }

  void applyFilters() {
    int limit = userPlan.value == 'Basic'
        ? 40
        : (userPlan.value == 'Premium' ? allProducts.length : 10);
    displayedProducts.value = allProducts.take(limit).toList();
  }

  void setupScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !isLoading.value &&
          !isLastPage.value) {
        loadMore();
      }
    });
  }

  void loadMore() {
    currentPage++;
    applyFilters();
  }

  bool get isFlashSaleTime {
    final now = DateTime.now();
    return (now.hour >= 8 &&
        (now.hour < 12 || (now.hour == 12 && now.minute <= 30)));
  }

  List<Product> get flashSaleProducts {
    return isFlashSaleTime
        ? allProducts
            .where((p) => p.category.toLowerCase().contains("flash"))
            .toList()
        : [];
  }

  void addToCart(Product product) {
    if (product.stock == 0) {
      Get.snackbar('Out of Stock', '${product.title} is out of stock.');
      return;
    }

    final currentCount = cart[product] ?? 0;

    if (userPlan.value == 'Free' && cart.length == 1) {
      Get.defaultDialog(
        title: "Upgrade Required",
        content: Text("Upgrade to Basic or Premium to add more items."),
      );
      return;
    }

    if (userPlan.value == 'Basic' && cart.length >= 5) {
      Get.defaultDialog(
        title: "Limit Reached",
        content: Text("You've reached the Basic plan cart limit."),
      );
      return;
    }

    if (currentCount < product.stock) {
      cart[product] = currentCount + 1;
      suggestBasedOn(product);
    } else {
      Get.snackbar('Stock Limit', 'All available stock already in cart.');
    }
  }

  void removeFromCart(Product product) {
    if (cart.containsKey(product)) {
      final updatedCount = (cart[product]! - 1).clamp(0, product.stock);
      if (updatedCount == 0) {
        cart.remove(product);
      } else {
        cart[product] = updatedCount;
      }
    }
  }

  void search(String query) {
    searchQuery.value = query;
    currentPage = 1;
    applyFilters();
    HiveService.saveSearchKeyword(query);
  }

  void suggestBasedOn(Product product) {
    suggestions.value = allProducts
        .where((p) => p.category == product.category && p.id != product.id)
        .take(3)
        .toList();
  }

  Future<void> loadSearchKeywords() async {
    keywordSuggestions.value = await HiveService.getSearchKeywords();
  }

  int getProductQuantity(Product product) => cart[product] ?? 0;

  bool isOutOfStock(Product product) => product.stock == 0;
}
