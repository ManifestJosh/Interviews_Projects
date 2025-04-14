import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plan_upgrade_app/views/cartPage.dart';
import '../controllers/product_controller.dart';
import '../models/product.dart';
import 'widgets/flashsales.dart';
import 'widgets/product_tile.dart';
import 'widgets/search_bar.dart';

class ProductListPage extends StatelessWidget {
  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products (${controller.userPlan.value} Plan)'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => Get.to(() => CartPage()),
          )
        ],
      ),
      body: Column(
        children: [
          Builder(builder: (_) {
            final flashSale = controller.isFlashSaleTime; // non-reactive getter
            return flashSale
                ? FlashSaleWidget()
                : Container(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "🕗 Get ready for the Flash Sale from 8:00 AM to 12:30 PM!",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  );
          }),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              return ListView.builder(
                controller: controller.scrollController,
                itemCount: controller.displayedProducts.length,
                itemBuilder: (context, index) {
                  final product = controller.displayedProducts[index];
                  return ProductTile(product: product);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
