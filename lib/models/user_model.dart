class UserModel {
  String? token;
  int? id;
  String? name;
  String? email;
  String? username;
  String? roles;
  String? phone;
  String? emailVerifiedAt;
  String? currentTeamId;
  String? profilePhotoPath;
  String? createdAt;
  String? updatedAt;
  String? profilePhotoUrl;
  String? address;

  UserModel({
    this.token,
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
    this.address,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    roles = json['roles'];
    phone = json['phone'];
    emailVerifiedAt = json['email_verified_at'];
    currentTeamId = json['current_team_id'];
    profilePhotoPath = json['profile_photo_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profilePhotoUrl = json['profile_photo_url'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['token'] = this.token;
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['username'] = this.username;
    data['roles'] = this.roles;
    data['phone'] = this.phone;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['current_team_id'] = this.currentTeamId;
    data['profile_photo_path'] = this.profilePhotoPath;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['profile_photo_url'] = this.profilePhotoUrl;
    data['address'] = this.address;
    return data;
  }
}
