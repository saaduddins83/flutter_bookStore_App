import 'package:app_book_store/providers/cartProvider.dart';
import 'package:app_book_store/screens/checkOutScreen.dart';
import 'package:app_book_store/widgets/chipsStyle.dart';
import 'package:app_book_store/widgets/iconBtnWithCounter.dart';
import 'package:app_book_store/widgets/icons.dart';
import 'package:app_book_store/widgets/productCard.dart';
import 'package:flutter/material.dart';
import 'package:app_book_store/models/product.dart' as model_product;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final model_product.Product product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Stack(children: [
                IconBtnWithCounter(
                  numOfitem: cart.numOfItems,
                  svgSrc: cartIcon,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutScreen(
                          cartItems: cart.cartItems,
                        ),
                      ),
                    );
                  },
                ),
              ]);
            },
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    widget.product.images[0],
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                widget.product.title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Rs. ${widget.product.price}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                widget.product.description,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 16.0),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: widget.product.categories.map((category) {
                  return Chip(
                    label: Text(
                      category,
                      style: getCategoryTextStyle(category),
                    ),
                    backgroundColor: getCategoryBackgroundColor(category),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: const Color.fromARGB(255, 240, 240, 240),
                    ),
                    child: Row(children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: decrementQuantity,
                      ),
                      Text(
                        quantity.toString(),
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: incrementQuantity,
                      ),
                    ]),
                  ),
                  Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        elevation: 5,
                        padding: EdgeInsets.all(20),
                        minimumSize: Size(150, 40)),
                    onPressed: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .addToCart(
                        widget.product, // Pass the current product
                        quantity, // Pass the current quantity selected
                      );
                    },
                    child: Text('Add to Cart',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Divider(),
              SizedBox(height: 16.0),
              Text(
                'Reviews',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              _buildReview('John Doe', 'Great product! Highly recommend.', 5,
                  '2023-10-01'),
              _buildReview(
                  'Jane Smith', 'Good value for money.', 4, '2023-09-28'),
              _buildReview('Alice Johnson', 'Satisfied with the purchase.', 4,
                  '2023-09-25'),
              _buildReview('Bob Brown', 'Could be better.', 3, '2023-09-20'),
              _buildReview(
                  'Charlie Davis', 'Not what I expected.', 2, '2023-09-15'),
              PopularProducts()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReview(String name, String review, int rating, String date) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border:
            Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              Text(
                date,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 20.0,
              );
            }),
          ),
          SizedBox(height: 8.0),
          Text(
            review,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class PopularProducts extends StatelessWidget {
  const PopularProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            "You might\nalso like".toUpperCase(),
            style:
                GoogleFonts.candal(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: model_product.products.sublist(0, 6).length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ProductCard(
                  product: model_product.products[index],
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                            product: model_product.products[index]),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
