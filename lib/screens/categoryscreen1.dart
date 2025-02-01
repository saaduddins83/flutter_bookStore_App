import 'package:app_book_store/models/product.dart';
import 'package:flutter/material.dart';
import 'package:app_book_store/models/book.dart';
import 'package:app_book_store/services/firestore_service.dart';
import 'package:app_book_store/screens/productDetailScreen.dart';

class Categoryscreen1 extends StatefulWidget {
  // final String category; // Pass the category name as a parameter

  const Categoryscreen1({
    super.key,
  });
// required this.category
  @override
  State<Categoryscreen1> createState() => _Categoryscreen1State();
}

class _Categoryscreen1State extends State<Categoryscreen1> {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category: "),
      ),
      // ${widget.category}
      body: SafeArea(
        child: StreamBuilder<List<Book>>(
          stream: _firestoreService.fetchBooksByCategory(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No books found.'));
            }

            final books = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: books.map((book) {
                  return BookCard(book: book);
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(product: products[])));
      },
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset('assets/Images/01.jpg',
                    width: 100, height: 150, fit: BoxFit.cover),
                // child: Image.network(
                //   "", // Replace with book image URL
                //   width: 100.0,
                //   height: 150.0,
                //   fit: BoxFit.cover,
                // ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      book.description,
                      style: const TextStyle(color: Colors.grey),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Rs. ${book.price}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
