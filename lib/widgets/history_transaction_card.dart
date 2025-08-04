import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import '../dimens.dart';
import '../models/models.dart';
import '../theme.dart';

class HistoryTransactionCard extends StatelessWidget {
  final TransactionHistoryModel item;
  const HistoryTransactionCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    Jiffy.setLocale("ID");
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        vertical: Spacing.base,
        horizontal: Spacing.base,
      ),
      padding: const EdgeInsets.all(Spacing.base),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: backgroundColor4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Created Order \n${Jiffy.parse(item.createdAt.toString()).format(pattern: 'EEEE, do MMMM yyyy, h:mm a')}",
            style: primaryTextStyle,
          ),
          Divider(color: Colors.white, thickness: 0.8),
          const SizedBox(height: Spacing.dp),
          Text("Item Order", style: primaryTextStyle),
          const SizedBox(height: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: item.items!
                .map(
                  (item) => Container(
                    margin: const EdgeInsets.only(bottom: Spacing.base),
                    padding: EdgeInsets.symmetric(horizontal: Spacing.dp),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            item.galleries![0].url!,
                            width: 60,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Name Product : ${item.product?.name.toString()}",
                                style: secondaryTextStyle,
                              ),
                              Text(
                                "Price : \$${item.product?.price.toString()}",
                                style: secondaryTextStyle,
                              ),
                              Text(
                                "Quantity : ${item.quantity.toString()}",
                                style: secondaryTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          Divider(color: Colors.white, thickness: 0.8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Price", style: primaryTextStyle),
              Text("\$${item.totalPrice.toString()}", style: primaryTextStyle),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Shipping Price", style: primaryTextStyle),
              Text(
                "\$${item.shippingPrice.toString()}",
                style: primaryTextStyle,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Status", style: primaryTextStyle),
              Text(item.status.toString(), style: primaryTextStyle),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Payment", style: primaryTextStyle),
              Text(item.payment.toString(), style: primaryTextStyle),
            ],
          ),
        ],
      ),
    );
  }
}
