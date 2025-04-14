import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';

class CartPage extends StatelessWidget {
  final ProductController controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: Obx(() {
        if (controller.cart.isEmpty) {
          return Center(child: Text("🛒 Your cart is empty."));
        }

        return Column(
          children: [
            Expanded(
              child: ListView(
                children: controller.cart.entries.map((entry) {
                  final product = entry.key;
                  final qty = entry.value;
                  final inStock = product.stock > qty;

                  return ListTile(
                    title: Text(product.title),
                    subtitle: Text(
                        "Price: \$${product.price} | Stock: ${product.stock}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove_circle_outline),
                          onPressed: () => controller.removeFromCart(product),
                        ),
                        Text(qty.toString(), style: TextStyle(fontSize: 18)),
                        IconButton(
                          icon: Icon(Icons.add_circle_outline),
                          onPressed: () => controller.addToCart(product),
                        ),
                      ],
                    ),
                    tileColor: inStock ? Colors.white : Colors.red.shade100,
                  );
                }).toList(),
              ),
            ),
            Obx(() {
              if (controller.suggestions.isEmpty) return SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Suggested for you",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  ...controller.suggestions
                      .map((p) => ListTile(title: Text(p.title)))
                ],
              );
            })
          ],
        );
      }),
    );
  }
}
