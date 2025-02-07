import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_book_store/models/product.dart';

class Productsprovider with ChangeNotifier {
  final List<Product> _products = [];
  bool isloading = true;
  List<Product> get products => _products;

  Future fetchProducts() async {
    try {
      final data =
          await FirebaseFirestore.instance.collection('products').get();
      if (data.docs.isEmpty) {
        products.clear();
      }

      _products.addAll(productsFromJson(data.docs));
    } catch (e) {
      print(e.toString());
    }
    isloading = false;
    notifyListeners();
  }
}
