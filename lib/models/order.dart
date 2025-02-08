import 'package:app_book_store/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_book_store/models/cart.dart';

class Order {
  final String id;
  final String userId;
  final List<CartItem> items;
  final double totalAmount;
  final DateTime timestamp;
  final String status;

  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.timestamp,
    required this.status,
    required Timestamp orderDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'items': items
          .map((item) => {
                'productId': item.product.id,
                'title': item.product.title,
                'price': item.product.price,
                'quantity': item.quantity,
              })
          .toList(),
      'totalAmount': totalAmount,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      userId: json['userId'],
      items: (json['items'] as List)
          .map((item) => CartItem(
                product: Product(
                  id: item['productId'],
                  title: item['title'],
                  price: item['price'],
                  images: [],
                  description: '',
                  categories: [],
                ),
                quantity: item['quantity'],
              ))
          .toList(),
      totalAmount: json['totalAmount'],
      timestamp: DateTime.parse(json['timestamp']),
      orderDate: (json['orderDate'] as Timestamp),
      status: '',
    );
  }
}
