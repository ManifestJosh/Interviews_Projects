import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../data/models/student_model.dart';
import '../../../data/datasources/student_local_datasource.dart';
import '../../../domain/services/fee_calculator.dart';

class StudentController extends GetxController {
  final StudentLocalDataSource localDataSource = StudentLocalDataSource();
  final students = <StudentModel>[].obs;

  final nameController = TextEditingController();
  final gradeController = TextEditingController();
  var hasSiblings = false.obs;
  var isTopPerformer = false.obs;
  DateTime selectedDueDate = DateTime.now()
      .add(Duration(days: 7)); // Default due date (1 week after resumption)

  @override
  void onInit() {
    loadStudents();
    super.onInit();
  }

  void loadStudents() async {
    students.value = await localDataSource.getAllStudents();
    calculateFeeForAll();
  }

  void calculateFeeForAll() {
    for (var student in students) {
      double fee = FeeCalculator.calculateFee(
        grade: student.grade,
        hasSiblings: student.hasSibling,
        isTopPerformer: student.isTopPerformer,
        resumptionDate: student.resumptionDate,
        paymentDate: student.paymentDate,
        dueDate: student.dueDate, // Pass due date here
      );
      student.totalPaid = fee;
    }
    students.refresh();
  }

  void addStudent() async {
    final student = StudentModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: nameController.text.trim(),
      grade: int.tryParse(gradeController.text.trim()) ?? 1,
      hasSibling: hasSiblings.value,
      isTopPerformer: isTopPerformer.value,
      resumptionDate: DateTime.now(),
      paymentDate: DateTime.now(),
      dueDate: selectedDueDate, // Store due date
    );

    await localDataSource.saveStudent(student);
    nameController.clear();
    gradeController.clear();
    hasSiblings.value = false;
    isTopPerformer.value = false;
    loadStudents();
  }
}
