import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/food_item.dart';
import '../constants.dart';

class FoodItemOverView extends StatelessWidget {
  final FoodItem foodItem;

  FoodItemOverView({
    @required this.foodItem,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          foodItem.imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Positioned(
          bottom: 30,
          left: 0,
          child: Container(
            color: Colors.black54,
            width: 220,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              child: Text(
                foodItem.title,
                softWrap: true,
                overflow: TextOverflow.fade,
                style: kTitleTextStyle.copyWith(
                  color: Colors.white,
                  //fontWeight: FontWeight.normal,
                  //letterSpacing: 1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
