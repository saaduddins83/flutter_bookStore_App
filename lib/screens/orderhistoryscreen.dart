import 'package:app_book_store/providers/orderProvider.dart';
import 'package:app_book_store/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      return Center(child: Text('Please log in to view your orders.'));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
            );
          },
        ),
      ),
      body: FutureBuilder(
        future: Provider.of<OrderProvider>(context, listen: false)
            .fetchOrders(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final orders = Provider.of<OrderProvider>(context).orders;

          if (orders.isEmpty) {
            return Center(child: Text('No orders found.'));
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text('Order #${order.id}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total: Rs. ${order.totalAmount}'),
                      Text('Status: ${order.status}'),
                      Text('Date: ${order.timestamp.toString()}'),
                    ],
                  ),
                  onTap: () {
                    // Navigate to order details if needed
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
