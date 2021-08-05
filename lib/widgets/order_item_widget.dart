import 'dart:math';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/providers/my_orders_provider.dart';
import 'package:intl/intl.dart';
import '../constants.dart';

class OrderItemWidget extends StatefulWidget {
  final MyOrder orderItem;

  OrderItemWidget({@required this.orderItem});

  @override
  _OrderItemWidgetState createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          ListTile(
            title: Text(
              DateFormat('dd MM yyyy hh:mm').format(widget.orderItem.date),
              style: kTextStyle,
            ),
            subtitle: Text(
              '${widget.orderItem.amount} ل.س',
              style: kPriceTextStyle,
            ),
            trailing: IconButton(
                icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                }),
          ),
          if(_isExpanded)
            Container(
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text('العنوان:', style: kTextStyle.copyWith(color: Colors.white),),
                subtitle: Text(widget.orderItem.address, style: kTextStyle.copyWith(color: Colors.white),),
              ),
            ),
          if (_isExpanded)
            Container(
              padding: const EdgeInsets.all(10),
              height: min(180, widget.orderItem.items.length * 20.0 + 60),
              child: ListView.builder(
                itemCount: widget.orderItem.items.length,
                itemBuilder: (context , index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.orderItem.items[index].title, style: kTextStyle.copyWith(fontWeight: FontWeight.normal, fontSize: 16,),),
                      Spacer(),
                      Text('${widget.orderItem.items[index].price} ل.س', style: kPriceTextStyle,),
                      const SizedBox(width: 10,),
                      Text('عدد ${widget.orderItem.items[index].quantity}', style: kPriceTextStyle,),
                    ],
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
