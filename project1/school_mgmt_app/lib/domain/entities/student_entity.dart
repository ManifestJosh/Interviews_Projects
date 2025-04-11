class StudentEntity {
  final String id;
  final String name;
  final int grade;
  final bool hasSiblings;
  final bool isTopPerformer;
  final DateTime resumptionDate;
  final DateTime paymentDate;
  double totalPaid;

  StudentEntity({
    required this.id,
    required this.name,
    required this.grade,
    required this.hasSiblings,
    required this.isTopPerformer,
    required this.resumptionDate,
    required this.paymentDate,
    this.totalPaid = 0.0,
  });
}