import 'package:get_it/get_it.dart';

import 'config.dart';
import 'dio_helper.dart';
import 'storage_service.dart';

final getIt = GetIt.instance;

void setupGetit() {
  getIt.registerSingleton<StorageService>(StorageService());
}

initDb() async {
  await getIt<StorageService>().initHiveStorage();
  await getIt<StorageService>().initHiveBox('config');
}

initApiConfig() async {
  await DioHelper.init(Config().baseUrl!);
}
