import 'package:get/get.dart';
import '../../../domain/entities/student_entity.dart';
import '../../../domain/usecases/calculate_fee_usecase.dart';

class FeeController extends GetxController {
  final CalculateFeeUseCase feeUseCase;
  FeeController(this.feeUseCase);

  var students = <StudentEntity>[].obs;
  var balances = <String, double>{}.obs;

  void makePayment(String studentId, double amount, DateTime closingDate) {
    final student = students.firstWhere((s) => s.id == studentId);
    final finalFee = feeUseCase.calculateFinalFee(student, closingDate);

    student.totalPaid += amount;
    balances[student.id] = finalFee - student.totalPaid;

    if ((finalFee - student.totalPaid) <= 0) {
      balances[student.id] = 0;
    }
    update();
  }

  String getStudentStatus(StudentEntity student, DateTime closingDate) {
    final daysLate = student.paymentDate.difference(closingDate).inDays;
    if (daysLate > 30) return "Pending Payment";
    if ((balances[student.id] ?? 0) == 0) return "Paid";
    return "Partially Paid";
  }
}