import '../entities/student_entity.dart';

class CalculateFeeUseCase {
  double getTuition(int grade) {
    switch (grade) {
      case 1: return 100000;
      case 2: return 120000;
      case 3: return 150000;
      default: return 100000;
    }
  }

  double calculateDiscount(StudentEntity student) {
    double discount = 0.0;
    if (student.hasSiblings) discount += 0.10;
    if (student.isTopPerformer) discount += 0.15;
    if (student.paymentDate.difference(student.resumptionDate).inDays <= 7) {
      discount += 0.05;
    }
    return discount;
  }

  double calculatePenalty(StudentEntity student, DateTime closingDate) {
    final daysLate = student.paymentDate.difference(closingDate).inDays;
    if (daysLate > 30) return 0.05;
    if (daysLate > 10) return 0.05;
    return 0.0;
  }

  double calculateFinalFee(StudentEntity student, DateTime closingDate) {
    final tuition = getTuition(student.grade);
    final discountAmount = tuition * calculateDiscount(student);
    final penaltyAmount = tuition * calculatePenalty(student, closingDate);
    return tuition - discountAmount + penaltyAmount;
  }
}