// product_tile.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/product_controller.dart';
import '../../models/product.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  ProductTile({required this.product});

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.find();
    final inCart = controller.cart.containsKey(product);
    final quantity = controller.cart[product] ?? 0;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        onTap: () => Get.to(() => ProductDetailPage(product: product)),
        leading: Image.network(product.image, width: 50, height: 50),
        title: Text(product.title),
        subtitle: Text("₦${product.price}"),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (product.stock == 0)
              Text("Out of Stock", style: TextStyle(color: Colors.red))
            else if (inCart)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    onPressed: () => controller.removeFromCart(product),
                  ),
                  Text('$quantity'),
                  IconButton(
                    icon: Icon(Icons.add_circle_outline),
                    onPressed: quantity < product.stock
                        ? () => controller.addToCart(product)
                        : null,
                  ),
                ],
              )
            else
              ElevatedButton(
                onPressed: () => controller.addToCart(product),
                child: Text("Add to Cart"),
              ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final Product product;

  ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();
    final quantity = controller.cart[product] ?? 0;

    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.network(product.image, height: 200)),
            SizedBox(height: 16),
            Text(product.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("₦${product.price}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text(product.description),
            SizedBox(height: 16),
            product.stock == 0
                ? Text("Out of Stock", style: TextStyle(color: Colors.red))
                : Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove_circle_outline),
                        onPressed: () => controller.removeFromCart(product),
                      ),
                      Text('$quantity'),
                      IconButton(
                        icon: Icon(Icons.add_circle_outline),
                        onPressed: quantity < product.stock
                            ? () => controller.addToCart(product)
                            : null,
                      ),
                    ],
                  ),
            SizedBox(height: 20),
            Obx(() {
              final suggestions = controller.suggestions;
              if (suggestions.isEmpty) return SizedBox();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("You may also like",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Column(
                    children: suggestions
                        .map((p) => ListTile(
                              title: Text(p.title),
                              subtitle: Text("₦${p.price}"),
                              leading: Image.network(p.image, width: 40),
                              onTap: () =>
                                  Get.to(() => ProductDetailPage(product: p)),
                            ))
                        .toList(),
                  )
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
