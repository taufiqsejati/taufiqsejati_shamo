import 'dart:convert';

import 'package:dio/dio.dart';
import '../models/models.dart';
import '../utils/utils.dart';

class TransactionService {
  String baseUrl = 'http://project-taufiqsejati.my.id/api';

  Future<bool> checkout(
    String? token,
    String? address,
    List<CartModel> carts,
    double? totalPrice,
  ) async {
    // var url = Uri.parse('$baseUrl/checkout');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token.toString(),
    };
    var body = jsonEncode({
      'address': address,
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

    if (response.statusCode == 200) {
      List data = response.data['data']['data'];
      List<TransactionHistoryModel> transactionHistory = [];

      for (var item in data) {
        transactionHistory.add(TransactionHistoryModel.fromJson(item));
        transactionHistory.sort(
          (TransactionHistoryModel a, TransactionHistoryModel b) =>
              b.createdAt!.compareTo(a.createdAt!),
        );
      }
      print(transactionHistory);
      return transactionHistory;
    } else {
      throw Exception('Gagal Get Products!');
    }
  }
}
