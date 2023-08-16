// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geolocation_repo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HivePositionAdapter extends TypeAdapter<HivePosition> {
  @override
  final int typeId = 5;

  @override
  HivePosition read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HivePosition(
      fields[0] as double,
      fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, HivePosition obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.lat)
      ..writeByte(1)
      ..write(obj.lon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HivePositionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
