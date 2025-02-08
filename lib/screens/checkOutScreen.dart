import 'package:app_book_store/providers/cartProvider.dart';
import 'package:app_book_store/providers/orderProvider.dart';
import 'package:app_book_store/screens/orderhistoryscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_book_store/models/cart.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  final List<CartItem> cartItems;

  const CheckoutScreen({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    double totalAmount = 0;
    cartItems.forEach((cartItem) {
      totalAmount += cartItem.product.price * cartItem.quantity;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        centerTitle: true,
        shape: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return CartItemTile(cartItem: cartItems[index]);
                },
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subtotal:',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Rs. $totalAmount',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Discount:',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black.withValues(alpha: 0.7),
                        ),
                      ),
                      Text(
                        'Rs. 0',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),

                  // Shipping
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Shipping:',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black.withValues(alpha: 0.7),
                        ),
                      ),
                      Text(
                        'Rs. 50',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.0),
                  Divider(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total:',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Rs. ${totalAmount + 50}',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: ElevatedButton(
                  child: Text('Proceed to Payment'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding:
                        EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  onPressed: () async {
                    final userId = FirebaseAuth.instance.currentUser?.uid;
                    if (userId == null) {
                      // Show error message
                      return;
                    }

                    await Provider.of<OrderProvider>(context, listen: false)
                        .addOrder(userId, cartItems, totalAmount + 50);

                    // Clear cart after order is placed
                    Provider.of<CartProvider>(context, listen: false)
                        .cartItems
                        .clear();
                    Provider.of<CartProvider>(context, listen: false)
                        .notifyListeners();

                    // Navigate to Order History
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderHistoryScreen()),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// final confirmation page lagana hy
// Navigator.push(context, MaterialPageRoute(...));

class CartItemTile extends StatelessWidget {
  final CartItem cartItem;

  const CartItemTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withValues(alpha: 0.2), blurRadius: 8.0)
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                cartItem.product.images[0],
                height: 80.0,
                width: 80.0,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.product.title,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Rs. ${cartItem.product.price}',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'x ${cartItem.quantity}',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black.withValues(alpha: 0.7),
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Rs. ${cartItem.product.price * cartItem.quantity}',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
