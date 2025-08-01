import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../theme.dart';
import '../utils/config.dart';
import '../widgets/widgets.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    TransactionProvider transactionProvider = Provider.of<TransactionProvider>(
      context,
    );
    // AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleCheckout() async {
      setState(() {
        isLoading = true;
      });

      if (await transactionProvider.checkout(
        Config().token.toString(),
        Config().users.address.toString(),
        cartProvider.carts,
        cartProvider.totalPrice(),
      )) {
        cartProvider.carts = [];
        Navigator.pushNamed(context, '/checkout-success');
      }

      setState(() {
        isLoading = false;
      });
    }

    PreferredSizeWidget header() {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primaryTextColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: backgroundColor1,
        elevation: 0,
        centerTitle: true,
        title: Text('Checkout Details', style: primaryTextStyle),
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          // NOTE: LIST ITEMS
          Container(
            margin: EdgeInsets.only(top: defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'List Items',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                Column(
                  children: cartProvider.carts
                      .map((cart) => CheckoutCard(cart))
                      .toList(),
                ),
              ],
            ),
          ),

          // NOTE: ADDRESS DETAILS
          Container(
            margin: EdgeInsets.only(top: defaultMargin),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: backgroundColor4,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Address Details',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/icon_store_location.png',
                          width: 40,
                        ),
                        Image.asset('assets/icon_line.png', height: 30),
                        Image.asset('assets/icon_your_address.png', width: 40),
                      ],
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Store Location',
                          style: secondaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: light,
                          ),
                        ),
                        Text(
                          'Adidas Core',
                          style: primaryTextStyle.copyWith(fontWeight: medium),
                        ),
                        SizedBox(height: defaultMargin),
                        Text(
                          'Your Address',
                          style: secondaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: light,
                          ),
                        ),
                        Text(
                          Config().users.address ?? '-',
                          style: primaryTextStyle.copyWith(fontWeight: medium),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // NOTE: PAYMENT SUMMARY
          Container(
            margin: EdgeInsets.only(top: defaultMargin),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: backgroundColor4,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Summary',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Product Quantity',
                      style: secondaryTextStyle.copyWith(fontSize: 12),
                    ),
                    Text(
                      '${cartProvider.totalItems()} Items',
                      style: primaryTextStyle.copyWith(fontWeight: medium),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Product Price',
                      style: secondaryTextStyle.copyWith(fontSize: 12),
                    ),
                    Text(
                      '\$${cartProvider.totalPrice()}',
                      style: primaryTextStyle.copyWith(fontWeight: medium),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Shipping',
                      style: secondaryTextStyle.copyWith(fontSize: 12),
                    ),
                    Text(
                      'Free',
                      style: primaryTextStyle.copyWith(fontWeight: medium),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Divider(thickness: 1, color: Color(0xff2E3141)),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: priceTextStyle.copyWith(fontWeight: semiBold),
                    ),
                    Text(
                      '\$${cartProvider.totalPrice()}',
                      style: priceTextStyle.copyWith(fontWeight: semiBold),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // NOTE: CHECKOUT BUTTON
          SizedBox(height: defaultMargin),
          Divider(thickness: 1, color: Color(0xff2E3141)),
          isLoading
              ? Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: LoadingButton(),
                )
              : Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: defaultMargin),
                  child: TextButton(
                    onPressed: handleCheckout,
                    style: TextButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Checkout Now',
                      style: primaryTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                ),
          SizedBox(height: defaultMargin * 2),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: header(),
      body: content(),
    );
  }
}
