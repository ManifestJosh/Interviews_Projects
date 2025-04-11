// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentModelAdapter extends TypeAdapter<StudentModel> {
  @override
  final int typeId = 0;

  @override
  StudentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentModel(
      id: fields[0] as String,
      name: fields[1] as String,
      grade: fields[2] as int,
      hasSibling: fields[3] as bool,
      isTopPerformer: fields[4] as bool,
      resumptionDate: fields[5] as DateTime,
      paymentDate: fields[6] as DateTime,
      dueDate: fields[7] as DateTime,
      totalPaid: fields[8] as double,
    );
  }

  @override
  void write(BinaryWriter writer, StudentModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.grade)
      ..writeByte(3)
      ..write(obj.hasSibling)
      ..writeByte(4)
      ..write(obj.isTopPerformer)
      ..writeByte(5)
      ..write(obj.resumptionDate)
      ..writeByte(6)
      ..write(obj.paymentDate)
      ..writeByte(7)
      ..write(obj.dueDate)
      ..writeByte(8)
      ..write(obj.totalPaid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
