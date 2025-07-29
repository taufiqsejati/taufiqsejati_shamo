import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

import '../dimens.dart';
import '../models/user_model.dart';
import '../providers/auth_provider.dart';
import '../providers/transaction_history_provider.dart';
import '../theme.dart';
import '../utils/config.dart';

class HistoryTransactionPage extends StatefulWidget {
  const HistoryTransactionPage({super.key});

  @override
  State<HistoryTransactionPage> createState() => _HistoryTransactionPageState();
}

class _HistoryTransactionPageState extends State<HistoryTransactionPage> {
  @override
  Widget build(BuildContext context) {
    Jiffy.setLocale("ID");
    // AuthProvider authProvider = Provider.of<AuthProvider>(context);
    // UserModel user = authProvider.user;
    TransactionHistoryProvider transactionHistoryProvider =
        Provider.of<TransactionHistoryProvider>(context);

    transactionHistoryProvider.getTransactionHistory(Config().token.toString());

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
        child: ListView(
          children: [
            Column(
              children: transactionHistoryProvider.transactionHistory
                  .map(
                    (e) => Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                        vertical: Spacing.base,
                        horizontal: Spacing.base,
                      ),
                      padding: const EdgeInsets.all(Spacing.base),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Id : ${e.id.toString()}",
                            style: primaryTextStyle,
                          ),
                          Text(
                            "Users Id : ${e.usersId.toString()}",
                            style: primaryTextStyle,
                          ),
                          Text(
                            "Total Price : ${e.totalPrice.toString()}",
                            style: primaryTextStyle,
                          ),
                          Text(
                            "Shipping Price : ${e.shippingPrice.toString()}",
                            style: primaryTextStyle,
                          ),
                          Text(
                            "Status : ${e.status.toString()}",
                            style: primaryTextStyle,
                          ),
                          Text(
                            "Payment : ${e.payment.toString()}",
                            style: primaryTextStyle,
                          ),
                          Text(
                            "Created : ${Jiffy.parse(e.createdAt.toString()).format(pattern: 'EEEE, do MMMM yyyy, h:mm a')}",
                            style: primaryTextStyle,
                          ),
                          Text("Item", style: primaryTextStyle),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: e.items!
                                .map(
                                  (e) => Container(
                                    margin: const EdgeInsets.only(
                                      bottom: Spacing.base,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Name Product : ${e.product?.name.toString()}",
                                          style: secondaryTextStyle,
                                        ),
                                        Text(
                                          "Quantity : ${e.quantity.toString()}",
                                          style: secondaryTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),

      resizeToAvoidBottomInset: false,
    );
  }
}
