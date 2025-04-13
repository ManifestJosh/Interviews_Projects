import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:plan_upgrade_app/database/hive_services.dart';

import 'models/product.dart';
import 'views/product_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  await HiveService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Offline Product List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductListPage(),
    );
  }
}
