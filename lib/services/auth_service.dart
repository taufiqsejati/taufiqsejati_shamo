import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shamo/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shamo/services/dio_helper.dart';

class AuthService {
  String baseUrl = 'http://project-taufiqsejati.my.id/api';

  Future<UserModel> register({
    String? name,
    String? username,
    String? email,
    String? password,
  }) async {
    // var url = Uri.parse('$baseUrl/register');
    // var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'name': name,
      'username': username,
      'email': email,
      'password': password,
    });

    final response = await DioHelper.dio!.post(
      '/register',
      data: body,
      options: Options(validateStatus: (status) => status! < 500),
    );
    // var response = await http.post(url, headers: headers, body: body);

    print(response.data);

    if (response.statusCode == 200) {
      var data = response.data['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];

      return user;
    } else {
      throw Exception('Gagal Register');
    }
  }

  Future<UserModel> login({String? email, String? password}) async {
    // var url = Uri.parse('$baseUrl/login');
    // var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({'email': email, 'password': password});

    // var response = await http.post(url, headers: headers, body: body);
    final response = await DioHelper.dio!.post(
      '/login',
      data: body,
      options: Options(validateStatus: (status) => status! < 500),
    );

    print(response.data);

    if (response.statusCode == 200) {
      var data = response.data['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];

      return user;
    } else {
      throw Exception('Gagal Login');
    }
  }
}
