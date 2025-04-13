import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:plan_upgrade_app/models/product.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shadowColor: Colors.grey,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: product.image,
              placeholder: (context, url) => CircularProgressIndicator(),
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
            Text(
              product.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "\$${product.price.toString()}",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        // title:
        // subtitle:
      ),
    );
  }
}
