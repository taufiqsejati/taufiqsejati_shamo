import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shamo/models/product_model.dart';
import 'package:shamo/utils/dio_helper.dart';

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

    print('sukses get data : ${response.data}');

    if (response.statusCode == 200) {
      List data = response.data['data']['data'];
      print('sukses get data 2 : ${data}');
      List<ProductModel> products = [];

      for (var item in data) {
        print('sukses procut $item');
        products.add(ProductModel.fromJson(item));
      }
      print('popular product');
      return products;
    } else {
      throw Exception('Gagal Get Products!');
    }
  }
}
