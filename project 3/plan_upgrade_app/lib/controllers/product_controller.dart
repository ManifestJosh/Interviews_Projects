import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plan_upgrade_app/models/product.dart';
import '../database/hive_services.dart';
import '../services/api_services.dart';

class ProductController extends GetxController {
  var allProducts = <Product>[];
  var displayedProducts = <Product>[].obs;
  var isLoading = false.obs;
  var isLastPage = false.obs;
  var currentPage = 1;
  final int pageSize = 10;

  var searchQuery = ''.obs;
  var keywordSuggestions = <String>[].obs;

  final ScrollController scrollController = ScrollController();

  // Simulate user plan (in a real app, this could come from user profile data)
  var userPlan = 'Free'.obs; // Can be 'Free', 'Basic', 'Premium'

  @override
  void onInit() {
    loadCachedProducts();
    fetchProducts();
    loadSearchKeywords();
    setupScrollListener();
    super.onInit();
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

  void loadCachedProducts() {
    allProducts = HiveService.getCachedProducts();
    applyFilters();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      final fetched = await ApiService.getProducts();
      allProducts = fetched;
      HiveService.cacheProducts(fetched);
      currentPage = 1;
      applyFilters();
    } finally {
      isLoading.value = false;
    }
  }

  void applyFilters() {
    List<Product> filtered = allProducts;

    if (searchQuery.value.isNotEmpty) {
      filtered = filtered
          .where((product) => product.title
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
          .toList();
    }

    // Apply user plan product limit
    int planLimit = 10; // Default Free
    if (userPlan.value == 'Basic') {
      planLimit = 40;
    } else if (userPlan.value == 'Premium') {
      planLimit = filtered.length;
    }

    final endIndex =
        (currentPage * pageSize).clamp(0, planLimit).clamp(0, filtered.length);
    displayedProducts.value = filtered.take(endIndex).toList();
    isLastPage.value = endIndex >= planLimit || endIndex >= filtered.length;
  }

  void search(String query) {
    searchQuery.value = query;
    currentPage = 1;
    applyFilters();
    HiveService.saveSearchKeyword(query);
  }

  void loadMore() {
    currentPage++;
    applyFilters();
  }

  Future<void> loadSearchKeywords() async {
    keywordSuggestions.value = await HiveService.getSearchKeywords();
  }

  List<Product> get flashSaleProducts {
    final now = DateTime.now();
    final isFlashTime = (now.hour >= 8 && now.hour < 12) ||
        (now.hour == 12 && now.minute <= 30);
    return isFlashTime
        ? allProducts
            .where((p) => p.title.toLowerCase().contains("flash"))
            .toList()
        : [];
  }

  bool isLocked(Product product) {
    // If user is Free and product title contains "premium" or "basic", it's locked
    if (userPlan.value == 'Free' &&
        (product.title.toLowerCase().contains('premium') ||
            product.title.toLowerCase().contains('basic'))) {
      return true;
    }
    // If user is Basic and product title contains "premium", it's locked
    if (userPlan.value == 'Basic' &&
        product.title.toLowerCase().contains('premium')) {
      return true;
    }
    return false;
  }

  bool canAddToCart(int currentCartCount) {
    if (userPlan.value == 'Free' && currentCartCount >= 3) return false;
    if (userPlan.value == 'Basic' && currentCartCount >= 3) return false;
    return true;
  }
}
