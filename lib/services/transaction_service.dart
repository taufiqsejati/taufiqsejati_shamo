import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shamo/models/transaction_history_model.dart';
import 'package:shamo/utils/dio_helper.dart';
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
      'items': carts
          .map((cart) => {'id': cart.product?.id, 'quantity': cart.quantity})
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

  Future<List<TransactionHistoryModel>> getTransactionHistory(
    String? token,
  ) async {
    // var url = Uri.parse('$baseUrl/products');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token.toString(),
    };

    final response = await DioHelper.dio!.get(
      '/transactions',
      options: Options(
        headers: headers,
        validateStatus: (status) => status! < 500,
      ),
    );
    // var response = await http.get(url, headers: headers);

    print('sukses get data : ${response.data}');

    if (response.statusCode == 200) {
      List data = response.data['data']['data'];
      print('sukses get data 2 : ${data}');
      List<TransactionHistoryModel> transactionHistory = [];

      for (var item in data) {
        print('sukses procut $item');
        transactionHistory.add(TransactionHistoryModel.fromJson(item));
      }
      print('popular product');
      return transactionHistory;
    } else {
      throw Exception('Gagal Get Products!');
    }
  }
}
