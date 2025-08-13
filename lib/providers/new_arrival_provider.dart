import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/services.dart';

class NewArrivalProvider with ChangeNotifier {
  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  set products(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }

  Future<void> getNewArrival() async {
    try {
      List<ProductModel> products = await ProductService().getNewArrival();
      _products = products;
    } catch (e) {
      print(e);
    }
  }
}
