// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MUsersAdapter extends TypeAdapter<MUsers> {
  @override
  final int typeId = 0;

  @override
  MUsers read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MUsers(
      id: fields[0] as int?,
      name: fields[1] as String?,
      email: fields[2] as String?,
      username: fields[3] as String?,
      roles: fields[4] as String?,
      phone: fields[5] as String?,
      emailVerifiedAt: fields[6] as String?,
      currentTeamId: fields[7] as String?,
      profilePhotoPath: fields[8] as String?,
      createdAt: fields[9] as String?,
      updatedAt: fields[10] as String?,
      profilePhotoUrl: fields[11] as String?,
      address: fields[12] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MUsers obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.username)
      ..writeByte(4)
      ..write(obj.roles)
      ..writeByte(5)
      ..write(obj.phone)
      ..writeByte(6)
      ..write(obj.emailVerifiedAt)
      ..writeByte(7)
      ..write(obj.currentTeamId)
      ..writeByte(8)
      ..write(obj.profilePhotoPath)
      ..writeByte(9)
      ..write(obj.createdAt)
      ..writeByte(10)
      ..write(obj.updatedAt)
      ..writeByte(11)
      ..write(obj.profilePhotoUrl)
      ..writeByte(12)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MUsersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
