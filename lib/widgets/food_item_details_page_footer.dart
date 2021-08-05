import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/food_item.dart';
import 'package:food_delivery_app/providers/my_cart_provider.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../my_services.dart';

class FoodItemDetailsPageFooter extends StatefulWidget {
  final FoodItem foodItem;

  FoodItemDetailsPageFooter({@required this.foodItem});
  @override
  _FoodItemDetailsPageFooterState createState() =>
      _FoodItemDetailsPageFooterState();
}

class _FoodItemDetailsPageFooterState extends State<FoodItemDetailsPageFooter> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final myCartProvider = Provider.of<MyCartProvider>(context, listen: false);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  quantity++;
                });
              },
              child: Icon(Icons.add),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                '$quantity',
                style: kTextStyle.copyWith(fontSize: 22),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (quantity > 1) quantity--;
                });
              },
              child: Icon(
                Icons.minimize,
                size: 35,
              ),
            ),
          ],
        ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${widget.foodItem.price} ل.س',
              style: kPriceTextStyle.copyWith(
                fontSize: 24,
                color: Colors.teal,
                //fontWeight: FontWeight.normal,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                myCartProvider.addItem(
                  widget.foodItem.id,
                  widget.foodItem.title,
                  widget.foodItem.price,
                  widget.foodItem.imageUrl,
                  quantity: quantity,
                );
                MyServices.displaySnackBar(context, 'تم إضافة هذا العنصر إلى السلة.');
              },
              icon: Icon(Icons.add_shopping_cart_outlined),
              label: Text(
                'إضافة إلى السلة',
                style: kTextStyle.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
