import 'package:flutter/material.dart';

import '../models/models.dart';
import '../services/services.dart';

class TransactionHistoryProvider with ChangeNotifier {
  List<TransactionHistoryModel> _transactionHistory = [];

  List<TransactionHistoryModel> get transactionHistory => _transactionHistory;

  set transactionHistory(List<TransactionHistoryModel> transactionHistory) {
    _transactionHistory = transactionHistory;
    notifyListeners();
  }

  Future<void> getTransactionHistory(String token) async {
    try {
      List<TransactionHistoryModel> transactionHistory =
          await TransactionService().getTransactionHistory(token);
      _transactionHistory = transactionHistory;
    } catch (e) {
      print(e);
    }
  }
}
