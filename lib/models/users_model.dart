// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'users_model.g.dart';

@HiveType(typeId: 0)
class MUsers {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? username;
  @HiveField(4)
  String? roles;
  @HiveField(5)
  String? phone;
  @HiveField(6)
  String? emailVerifiedAt;
  @HiveField(7)
  String? currentTeamId;
  @HiveField(8)
  String? profilePhotoPath;
  @HiveField(9)
  String? createdAt;
  @HiveField(10)
  String? updatedAt;
  @HiveField(11)
  String? profilePhotoUrl;
  MUsers({
    this.id,
    this.name,
    this.email,
    this.username,
    this.roles,
    this.phone,
    this.emailVerifiedAt,
    this.currentTeamId,
    this.profilePhotoPath,
    this.createdAt,
    this.updatedAt,
    this.profilePhotoUrl,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['username'] = this.username;
    data['roles'] = this.roles;
    data['phone'] = this.phone;
    data['emailVerifiedAt'] = this.emailVerifiedAt;
    data['currentTeamId'] = this.currentTeamId;
    data['profilePhotoPath'] = this.profilePhotoPath;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['profilePhotoUrl'] = this.profilePhotoUrl;
    return data;
  }
}
