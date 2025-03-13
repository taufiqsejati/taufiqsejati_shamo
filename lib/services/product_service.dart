import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shamo/models/product_model.dart';

class ProductService {
  String baseUrl = 'http://project-taufiqsejati.my.id/api';

  Future<List<ProductModel>> getProducts() async {
    var url = Uri.parse('$baseUrl/products');
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(url, headers: headers);

    print('sukses get data : ${response.body}');

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      print('sukses get data 2 : ${data}');
      List<ProductModel> products = [];

      for (var item in data) {
        print('sukses $item');
        products.add(ProductModel.fromJson(item));
      }
      print('popular product');
      return products;
    } else {
      throw Exception('Gagal Get Products!');
    }
  }
}
