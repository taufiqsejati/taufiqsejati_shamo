import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shamo/services/dio_helper.dart';
import '../models/cart_model.dart';

class TransactionService {
  String baseUrl = 'http://project-taufiqsejati.my.id/api';

  Future<bool> checkout(
    String? token,
    List<CartModel> carts,
    double? totalPrice,
  ) async {
    // var url = Uri.parse('$baseUrl/checkout');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token.toString(),
    };
    var body = jsonEncode({
      'address': 'Marsemoon',
      'items':
          carts
              .map(
                (cart) => {'id': cart.product?.id, 'quantity': cart.quantity},
              )
              .toList(),
      'status': "PENDING",
      'total_price': totalPrice,
      'shipping_price': 0,
    });

    final response = await DioHelper.dio!.post(
      '/checkout',
      data: body,
      options: Options(
        headers: headers,
        validateStatus: (status) => status! < 500,
      ),
    );
    // var response = await http.post(url, headers: headers, body: body);

    print(response.data);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Melakukan Checkout!');
    }
  }
}
