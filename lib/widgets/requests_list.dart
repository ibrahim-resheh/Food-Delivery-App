import 'package:flutter/material.dart';
import 'package:food_delivery_app/providers/my_orders_provider.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'order_item_widget.dart';

class RequestsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myOrdersProvider = Provider.of<MyOrdersProvider>(context);
    final myOrders = myOrdersProvider.myOrders;
    return myOrders.isEmpty
        ? Center(
            child: Text(
              'لا يوجد طلبات سابقة.',
              style: kTextStyle.copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
              itemCount: myOrdersProvider.myOrders.length,
              itemBuilder: (ctx, index) {
                return OrderItemWidget(orderItem: myOrders[index]);
              },
            ),
          );
  }
}
