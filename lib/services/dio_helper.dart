import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class DioHelper {
  static Dio? dio;
  static String? cookies;

  static Future init(String baseUrl) async {
    dio = Dio(BaseOptions(baseUrl: "$baseUrl/api"));
    dio?.options.headers['Content-Type'] = 'application/json';
    dio?.options.connectTimeout = Duration.zero;
    dio?.options.receiveTimeout = Duration.zero;
    dio?.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        // Config the client.
        client.findProxy = (uri) {
          // Forward all request to proxy "localhost:8888".
          // Be aware, the proxy should went through you running device,
          // not the host platform.
          return 'PROXY localhost:8000';
        };
        // You can also create a new HttpClient for Dio instead of returning,
        // but a client must being returned here.
        return client;
      },
    );
  }
}

initApiConfig() async {
  await DioHelper.init("http://192.168.77.19:8000");
}
