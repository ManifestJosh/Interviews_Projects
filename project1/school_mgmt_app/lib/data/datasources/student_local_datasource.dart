import 'package:hive/hive.dart';
import '../models/student_model.dart';

class StudentLocalDataSource {
  static const String boxName = 'studentsBox';

  Future<void> saveStudent(StudentModel student) async {
    final box = await Hive.openBox<StudentModel>(boxName);
    await box.put(student.id, student);
  }

  Future<List<StudentModel>> getAllStudents() async {
    final box = await Hive.openBox<StudentModel>(boxName);
    return box.values.toList();
  }

  Future<void> deleteStudent(String id) async {
    final box = await Hive.openBox<StudentModel>(boxName);
    await box.delete(id);
  }

  Future<void> clearAll() async {
    final box = await Hive.openBox<StudentModel>(boxName);
    await box.clear();
  }
}
