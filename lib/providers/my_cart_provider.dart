import 'package:flutter/foundation.dart';

class CartItem {
  String id;
  String title;
  int quantity;
  int price;
  String imageUrl;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
    @required this.imageUrl,
  });
}

class MyCartProvider with ChangeNotifier {
  Map<String, CartItem> _myCart = {};

  int get itemCount {
    return _myCart.length;
  }

  int get totalAmount {
    var total = 0;
    _myCart.forEach((foodItemId, cartItem) {
      total += cartItem.quantity * cartItem.price;
    });
    return total;
  }

  Map<String, CartItem> get myCart {
    return {..._myCart};
  }

  void addItem(String prodId, String title, int price, String imageUrl, {int quantity}) {
    //if product already exist in cart, just increase quantity
    if (_myCart.containsKey(prodId)) {
      _myCart.update(
        prodId,
        (existingProd) => CartItem(
          id: existingProd.id,
          title: existingProd.title,
          quantity: existingProd.quantity + (quantity ?? 1),
          price: existingProd.price,
          imageUrl: existingProd.imageUrl,
        ),
      );
    } else {
      _myCart.putIfAbsent(
        prodId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          quantity: quantity ?? 1,
          price: price,
          imageUrl: imageUrl,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String foodItemId){
    _myCart.remove(foodItemId);
    notifyListeners();
  }

  void clearCart(){
    _myCart = {};
    notifyListeners();
  }
}
