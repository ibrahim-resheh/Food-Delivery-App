import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/providers/my_cart_provider.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';


class CartItemWidget extends StatelessWidget {
  final String id;
  final String foodItemId;
  final String title;
  final int quantity;
  final int price;
  final String imageUrl;

  CartItemWidget({
    @required this.id,
    @required this.foodItemId,
    @required this.title,
    @required this.quantity,
    @required this.price,
    @required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 24;
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        padding: const EdgeInsets.only(right: 12),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        color: Colors.red,
        child: Icon(
          Icons.delete,
          size: 35,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
      ),
      direction: DismissDirection.startToEnd,
      onDismissed: (_) {
        Provider.of<MyCartProvider>(context, listen: false)
            .removeItem(foodItemId);
      },
      child: Card(
        elevation: 4,
        child: ListTile(
          leading: Container(
            width: width * 0.3,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            title,
            style: kTextStyle,
          ),
          subtitle: Text(
            '${price * quantity} ل.س',
            style: kPriceTextStyle,
          ),
          trailing: Text(
            '$quantity',
            style: kTextStyle,
          ),
        ),
      ),
    );
  }
}
