import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/services.dart';

class TransactionProvider with ChangeNotifier {
  Future<bool> checkout(
    String token,
    String address,
    List<CartModel> carts,
    double totalPrice,
  ) async {
    try {
      if (await TransactionService().checkout(
        token,
        address,
        carts,
        totalPrice,
      )) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
