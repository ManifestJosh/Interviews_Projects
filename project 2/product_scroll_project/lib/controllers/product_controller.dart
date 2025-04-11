import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_scroll_project/database/hive_services.dart';
import 'package:product_scroll_project/models/product.dart';
import 'package:product_scroll_project/services/api_services.dart';

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

    final endIndex = (currentPage * pageSize).clamp(0, filtered.length);
    displayedProducts.value = filtered.take(endIndex).toList();
    isLastPage.value = endIndex >= filtered.length;
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
}
