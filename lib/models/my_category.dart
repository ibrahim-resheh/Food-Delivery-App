import 'package:flutter/foundation.dart';
import 'food_item.dart';

class MyCategory {
  String id;
  String name;
  String imageUrl;
  List<FoodItem> foodItems;

  MyCategory({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
    @required this.foodItems,
  });
}
