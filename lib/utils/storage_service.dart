import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  Box getHiveBox(String name) {
    return Hive.box(name);
  }

  // Box getNotification()
  // Box getNotifications() => Hive.box<Notifications>('notifications');

  Future<Box> initHiveBox(String name) {
    return Hive.openBox(name);
  }

  // Future<Box> initHiveBoxNotifications() {
  //   return Hive.openBox<Notifications>('notifications');
  // }

  Future initHiveStorage() {
    return Hive.initFlutter();
  }
}
