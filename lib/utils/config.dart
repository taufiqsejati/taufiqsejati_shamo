import 'package:shamo/models/users_model.dart';

import '../data_dummy/data_dummy.dart';
import 'setup_locator.dart';
import 'storage_service.dart';

class Config {
  static var configContainer = getIt<StorageService>().getHiveBox('config');

  bool get isLoggedIn => configContainer.get('isLoggedIn', defaultValue: false);
  MUsers get users => configContainer.get('users', defaultValue: defaultUsers);

  String? get baseUrl => "http://192.168.77.19:8000";

  String? get email => configContainer.get('email');
  String? get fullName => configContainer.get('fullName');
  String? get username => configContainer.get('username');
  String? get password => configContainer.get('password');
  String? get token => configContainer.get('token');

  Uri? get uri {
    if (baseUrl == null) return null;
    return Uri.parse(baseUrl!);
  }

  static Future set(String k, dynamic v) async {
    configContainer.put(k, v);
  }

  static Future clear() async {
    configContainer.clear();
  }

  static Future remove(String k) async {
    configContainer.delete(k);
  }
}
