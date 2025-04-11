import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/product_controller.dart';

class SearchBarWidget extends StatelessWidget {
  final controller = Get.find<ProductController>();
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textController,
              onChanged: controller.search,
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          if (controller.keywordSuggestions.isNotEmpty)
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: controller.keywordSuggestions
                    .map((keyword) => ActionChip(
                          label: Text(keyword),
                          onPressed: () {
                            textController.text = keyword;
                            controller.search(keyword);
                          },
                        ))
                    .toList(),
              ),
            ),
        ],
      );
    });
  }
}
