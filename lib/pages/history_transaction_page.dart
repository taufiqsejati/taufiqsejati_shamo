import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../widgets/widgets.dart';
import '../theme.dart';

class HistoryTransactionPage extends StatefulWidget {
  const HistoryTransactionPage({super.key});

  @override
  State<HistoryTransactionPage> createState() => _HistoryTransactionPageState();
}

class _HistoryTransactionPageState extends State<HistoryTransactionPage> {
  @override
  Widget build(BuildContext context) {
    // AuthProvider authProvider = Provider.of<AuthProvider>(context);
    // UserModel user = authProvider.user;
    TransactionHistoryProvider transactionHistoryProvider =
        Provider.of<TransactionHistoryProvider>(context);

    // transactionHistoryProvider.getTransactionHistory(Config().token.toString());

    PreferredSizeWidget header() {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: primaryTextColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: backgroundColor1,
        elevation: 0,
        centerTitle: true,
        title: Text('Your Orders', style: primaryTextStyle),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: header(),
      body: SafeArea(
        child: transactionHistoryProvider.transactionHistory.isNotEmpty
            ? ListView(
                children: [
                  Column(
                    children: transactionHistoryProvider.transactionHistory
                        .map((e) => HistoryTransactionCard(item: e))
                        .toList(),
                  ),
                ],
              )
            : Container(
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Data Tidak Tersedia",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
      ),

      resizeToAvoidBottomInset: false,
    );
  }
}
