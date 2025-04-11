import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'student_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Fee Management'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.school, size: 100, color: Colors.indigo),
              const SizedBox(height: 20),
              const Text(
                "Welcome to the Student Fee Manager",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                icon: const Icon(Icons.payment),
                label: const Text("Manage Student Payments"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                onPressed: () {
                  Get.to(() => StudentPage());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}