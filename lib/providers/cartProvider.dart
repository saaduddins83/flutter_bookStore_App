import 'package:app_book_store/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:app_book_store/models/product.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(Product product, int quantity) {
    // Check if the product already exists in the cart
    final existingItemIndex =
        _cartItems.indexWhere((cartItem) => cartItem.product.id == product.id);

    if (existingItemIndex >= 0) {
      // If the product exists, increase its quantity
      _cartItems[existingItemIndex].quantity += quantity;
    } else {
      // Add a new product to the cart with the specified quantity
      _cartItems.add(CartItem(product: product, quantity: quantity));
    }

    notifyListeners(); // Notify listeners when cart is updated
  }

  int get numOfItems {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }
}
