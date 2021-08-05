import 'package:flutter/foundation.dart';

class FoodItem {
  String id;
  String title;
  int price;
  String ingredients;
  String imageUrl;
  bool isMostRequested;

  FoodItem({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.ingredients,
    @required this.imageUrl,
    this.isMostRequested = false,
  });
}
