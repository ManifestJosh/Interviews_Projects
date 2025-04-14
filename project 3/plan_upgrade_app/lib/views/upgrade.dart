import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';

class UpgradePage extends StatelessWidget {
  final ProductController controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upgrade Plan")),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(
            () => Column(
              children: [
                PlanCard(
                  title: "Free Plan",
                  description:
                      "Access up to 10 products.\nLimited cart features.",
                  isSelected: controller.userPlan.value == 'Free',
                  onTap: () => controller.userPlan.value = 'Free',
                ),
                SizedBox(height: 16),
                PlanCard(
                  title: "Basic Plan",
                  description:
                      "Access up to 40 products.\nCart limit: 5 items.",
                  isSelected: controller.userPlan.value == 'Basic',
                  onTap: () => controller.userPlan.value = 'Basic',
                ),
                SizedBox(height: 16),
                PlanCard(
                  title: "Premium Plan",
                  description: "Unlimited access.\nUnlimited cart items.",
                  isSelected: controller.userPlan.value == 'Premium',
                  onTap: () => controller.userPlan.value = 'Premium',
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Get.back(); // go back to product list
                  },
                  child:
                      Text("Continue with ${controller.userPlan.value} Plan"),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50)),
                )
              ],
            ),
          )),
    );
  }
}

class PlanCard extends StatelessWidget {
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const PlanCard({
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color:
            isSelected ? Colors.lightBlueAccent.withOpacity(0.3) : Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Icon(
                isSelected ? Icons.check_circle : Icons.circle_outlined,
                color: isSelected ? Colors.blue : Colors.grey,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 6),
                    Text(description,
                        style:
                            TextStyle(color: Colors.grey[700], fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
