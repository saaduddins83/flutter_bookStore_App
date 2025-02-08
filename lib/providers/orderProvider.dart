import 'package:app_book_store/models/cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:flutter/material.dart';
import 'package:app_book_store/models/order.dart';

class OrderProvider with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => _orders;

  Future<void> addOrder(
      String userId, List<CartItem> cartItems, double totalAmount) async {
    try {
      final orderId =
          firestore.FirebaseFirestore.instance.collection('orders').doc().id;

      Order newOrder = Order(
        id: orderId,
        userId: userId,
        items: cartItems,
        totalAmount: totalAmount,
        orderDate: firestore.Timestamp.now(),
        timestamp: DateTime.now(),
        status: '',
      );

      await firestore.FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId)
          .set(newOrder.toJson());

      _orders.add(newOrder);
      notifyListeners();
    } catch (e) {
      print('Error placing order: $e');
    }
  }

  Future<void> fetchOrders(String userId) async {
    try {
      final snapshot = await firestore.FirebaseFirestore.instance
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .orderBy('orderDate', descending: true)
          .get();

      _orders.clear();
      _orders.addAll(
          snapshot.docs.map((doc) => Order.fromJson(doc.data())).toList());
      notifyListeners();
    } catch (e) {
      print('Error fetching orders: $e');
    }
  }
}
