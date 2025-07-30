import 'package:dio/dio.dart';
import '../models/models.dart';
import '../utils/utils.dart';

class ProductService {
  String baseUrl = 'http://project-taufiqsejati.my.id/api';

  Future<List<ProductModel>> getProducts() async {
    // var url = Uri.parse('$baseUrl/products');
    // var headers = {'Content-Type': 'application/json'};

    final response = await DioHelper.dio!.get(
      '/products',
      options: Options(validateStatus: (status) => status! < 500),
    );
    // var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List data = response.data['data']['data'];
      List<ProductModel> products = [];

      for (var item in data) {
        products.add(ProductModel.fromJson(item));
      }
      return products;
    } else {
      throw Exception('Gagal Get Products!');
    }
  }
}
