class FeeCalculator {
  static const gradeFees = {
    1: 1000.0,
    2: 1200.0,
    3: 1500.0,
    4: 1800.0,
    5: 2000.0,
  };

  static const siblingDiscount = 0.1;
  static const meritDiscount = 0.15;
  static const earlyBirdDiscount = 0.2;
  static const latePenalty = 0.05;

  static double calculateFee({
    required int grade,
    required bool hasSiblings,
    required bool isTopPerformer,
    required DateTime resumptionDate,
    required DateTime paymentDate,
    required DateTime dueDate, // Added dueDate parameter
  }) {
    double baseFee = gradeFees[grade] ?? 1000.0;

    // Apply discounts
    double discount = 0.0;
    if (hasSiblings) {
      discount += siblingDiscount;
    }
    if (isTopPerformer) {
      discount += meritDiscount;
    }
    if (paymentDate.isBefore(resumptionDate.add(Duration(days: 7)))) {
      discount += earlyBirdDiscount;
    }

    baseFee -= baseFee * discount;

    // Apply late payment penalty based on due date
    final overdueDays = paymentDate.difference(dueDate).inDays;
    if (overdueDays > 0) {
      baseFee += baseFee * latePenalty;
    }

    return baseFee;
  }
}
