import 'package:app_book_store/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:app_book_store/models/product.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;
            
  void addToCart(Product product, int quantity) {
    final existingItemIndex =
        _cartItems.indexWhere((cartItem) => cartItem.product.id == product.id);

    if (existingItemIndex >= 1) {
      _cartItems[existingItemIndex].quantity += quantity;
    } else {
      _cartItems.add(CartItem(product: product, quantity: quantity));
    }

    notifyListeners();
  }

  int get numOfItems {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }
}
