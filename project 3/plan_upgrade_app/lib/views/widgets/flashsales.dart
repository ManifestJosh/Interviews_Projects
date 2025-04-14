import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/product_controller.dart';
import 'product_tile.dart';

class FlashSaleWidget extends StatelessWidget {
  final ProductController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final flashSaleProducts = controller.flashSaleProducts;

    if (flashSaleProducts.isEmpty) {
      return Container(
        padding: EdgeInsets.all(16),
        child: Text(
          "🎉 No flash sale products available at the moment!",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            "🔥 Flash Sale Products",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: flashSaleProducts.length,
          itemBuilder: (context, index) {
            return ProductTile(product: flashSaleProducts[index]);
          },
        ),
      ],
    );
  }
}
