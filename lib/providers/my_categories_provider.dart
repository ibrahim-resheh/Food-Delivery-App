import 'package:flutter/foundation.dart';
import 'package:food_delivery_app/models/food_item.dart';
import 'package:food_delivery_app/models/my_category.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyCategoriesProvider with ChangeNotifier {
  List<MyCategory> _myCategories = [];

  List<MyCategory> get myCategories {
    return [..._myCategories];
  }

  List<FoodItem> mostRequestedFoodItems(){
    List<FoodItem> mostRequested = [];
    _myCategories.forEach((category) {
      mostRequested.addAll(category.foodItems.where((foodItem) => foodItem.isMostRequested == true));
    });
    return mostRequested;
  }

  Future<void> fetchCategories() async {
    const url = 'https://fooddeliveryapp-bf9bd-default-rtdb.firebaseio.com/categories.json';
    try{
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<MyCategory> fetchedCategories = [];
      //convert fetched data which is a map to a list and store it in fetchedCategories
      extractedData.forEach((myCategoryId, myCategoryData) {
        //convert fetched foodItems which is a map to a list and store it in fetchedFoodItems
        final extractedFoodItems = myCategoryData['foodItems'] as Map<String, dynamic>;
        final List<FoodItem> fetchedFoodItems = [];
        extractedFoodItems.forEach((foodItemId, foodItemData) {
          print(foodItemId);
          print(foodItemData['imageUrl']);
          print(foodItemData['price']);
          print(foodItemData['ingredients']);
          print(foodItemData['isMostRequested']);
          fetchedFoodItems.add(
            FoodItem(
              id: foodItemId,
              title: foodItemData['title'],
              imageUrl: foodItemData['imageUrl'],
              price: foodItemData['price'],
              ingredients: foodItemData['ingredients'],
              isMostRequested: foodItemData['isMostRequested'],
            ),
          );
        });
        fetchedCategories.add(
          MyCategory(
            id: myCategoryId,
            name: myCategoryData['name'],
            imageUrl: myCategoryData['imageUrl'],
            foodItems: fetchedFoodItems,
          ),
        );
      });
      _myCategories = fetchedCategories;
      notifyListeners();
    }catch(e){
      print('Error Errors $e');
      throw e;
    }

  }

  MyCategory findCategoryById(String id){
    final category = _myCategories.firstWhere((element) => element.id == id);
    return category;
  }

}
