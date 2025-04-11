import 'package:hive/hive.dart';

part 'student_model.g.dart';

@HiveType(typeId: 0)
class StudentModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  int grade;

  @HiveField(3)
  bool hasSibling;

  @HiveField(4)
  bool isTopPerformer;

  @HiveField(5)
  DateTime resumptionDate;

  @HiveField(6)
  DateTime paymentDate;

  @HiveField(7)
  DateTime dueDate;

  @HiveField(8)
  double totalPaid;

  StudentModel({
    required this.id,
    required this.name,
    required this.grade,
    required this.hasSibling,
    required this.isTopPerformer,
    required this.resumptionDate,
    required this.paymentDate,
    required this.dueDate,
    this.totalPaid = 0.0,
  });
}
