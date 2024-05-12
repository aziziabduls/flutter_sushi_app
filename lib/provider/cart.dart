// import 'dart:convert';s

import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
import 'package:sushi_app/models/cart_model.dart';
import 'package:sushi_app/models/food.dart';

class Cart extends ChangeNotifier {
  // List<Food> _food = [];
  final List<CartModel> _cart = [];

  // List<Food> get allFood => _food;
  List<CartModel> get cart => _cart;

  // void getAllFood() async {
  //   String jsonString = await rootBundle.loadString('assets/json/food.json');
  //   List<dynamic> jsonMap = json.decode(jsonString);
  //   _food = jsonMap.map((json) => Food.fromJson(json)).toList();
  //   notifyListeners();
  // }

  void addToCart(Food foodItem, int qty) {
    _cart.add(
      CartModel(
        name: foodItem.name,
        imagePath: foodItem.imagePath,
        price: foodItem.price,
        quantity: qty.toString(),
      ),
    );
    notifyListeners();
  }

  void removeFromCart(CartModel itme) {
    _cart.remove(itme);
    notifyListeners();
  }
}
