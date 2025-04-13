import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';
import 'widgets/product_tile.dart';
import 'widgets/search_bar.dart';

class ProductListPage extends StatelessWidget {
  final controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: Column(
        children: [
          SearchBarWidget(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value &&
                  controller.displayedProducts.isEmpty) {
                return Center(child: CircularProgressIndicator());
              }

              return RefreshIndicator(
                onRefresh: controller.fetchProducts,
                child: GridView.builder(
                  controller: controller.scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.1,
                      crossAxisSpacing: 15),
                  itemCount: controller.displayedProducts.length +
                      (controller.isLastPage.value ? 0 : 1),
                  itemBuilder: (context, index) {
                    if (index < controller.displayedProducts.length) {
                      return ProductTile(
                          product: controller.displayedProducts[index]);
                    } else {
                      return Center(
                          child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ));
                    }
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
