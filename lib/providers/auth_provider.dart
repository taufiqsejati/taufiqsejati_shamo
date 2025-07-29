import 'package:flutter/material.dart';
import 'package:shamo/models/user_model.dart';
import 'package:shamo/models/users_model.dart';
import 'package:shamo/services/auth_service.dart';

import '../utils/config.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;

  UserModel get user => _user!;

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> register({
    String? name,
    String? username,
    String? email,
    String? password,
  }) async {
    try {
      UserModel user = await AuthService().register(
        name: name,
        username: username,
        email: email,
        password: password,
      );

      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login({String? email, String? password}) async {
    try {
      UserModel user = await AuthService().login(
        email: email,
        password: password,
      );

      _user = user;

      await Config.set('email', user.email);
      await Config.set('fullName', user.name);
      await Config.set('username', user.username);
      await Config.set('password', password);
      await Config.set('token', 'Bearer ${user.token.toString()}');
      await Config.set(
        'users',
        MUsers(
          id: user.id,
          email: user.email,
          name: user.name,
          username: user.username,
          phone: user.phone,
          roles: user.roles,
          currentTeamId: user.currentTeamId,
          profilePhotoUrl: user.profilePhotoUrl,
          emailVerifiedAt: user.emailVerifiedAt,
          profilePhotoPath: user.profilePhotoPath,
          createdAt: user.createdAt,
          updatedAt: user.updatedAt,
        ),
      );
      await Config.set('isLoggedIn', true);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateProfile({
    String? name,
    String? username,
    String? email,
    String? token,
  }) async {
    try {
      UserModel user = await AuthService().updateProfile(
        name: name,
        username: username,
        email: email,
        token: token,
      );

      _user = user;
      await Config.set('email', user.email);
      await Config.set('fullName', user.name);
      await Config.set('username', user.username);
      await Config.set(
        'users',
        MUsers(
          id: user.id,
          email: user.email,
          name: user.name,
          username: user.username,
          phone: user.phone,
          roles: user.roles,
          currentTeamId: user.currentTeamId,
          profilePhotoUrl: user.profilePhotoUrl,
          emailVerifiedAt: user.emailVerifiedAt,
          profilePhotoPath: user.profilePhotoPath,
          createdAt: user.createdAt,
          updatedAt: user.updatedAt,
        ),
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> logout(String token) async {
    try {
      if (await AuthService().logout(token)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
