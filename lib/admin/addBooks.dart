import 'package:app_book_store/models/product.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_book_store/models/book.dart';
import 'package:app_book_store/admin/book_listing.dart';
import 'package:uuid/uuid.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final Uuid uuid = Uuid();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final String bookId = uuid.v4();
      // Collect book data
      final product = Product(
        id: bookId, // Generate a unique ID
        title: _titleController.text,
        categories: ['Technology', 'Design'],
        images: [_imageController.text],
        rating: double.parse(_ratingController.text),
        price: double.parse(_priceController.text),
        description: _descriptionController.text,
      );

      // Send book data to backend
      addBookToBackend(product);
    }
  }

  Future<void> addBookToBackend(Product product) async {
    try {
      final firestore = FirebaseFirestore.instance;

      // Use book.id as the document ID
      await firestore
          .collection('products')
          .doc(product.id)
          .set(product.toJson());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Book added successfully!')),
      );

      // Clear form fields after successful submission
      _titleController.clear();
      _imageController.clear();
      _ratingController.clear();
      _priceController.clear();
      _descriptionController.clear();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Book'),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Title Field
                _buildTextField(
                  controller: _titleController,
                  label: 'Title',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the title';
                    }
                    return null;
                  },
                ),

                // Author Field
                _buildTextField(
                  controller: _imageController,
                  label: 'Image URL',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Image URL';
                    }
                    return null;
                  },
                ),

                // Author Field
                _buildTextField(
                  controller: _ratingController,
                  label: 'Rating',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter rating';
                    }
                    return null;
                  },
                ),
                // Price Field
                _buildTextField(
                  controller: _priceController,
                  label: 'Price',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),

                // Description Field
                _buildTextField(
                  controller: _descriptionController,
                  label: 'Description',
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Add Book Button
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    iconColor: Colors.teal, // Button color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Add Book',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 15),

                // Books List Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookListPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    iconColor: Colors.grey, // Button color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Books List',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.teal.shade50,
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator,
      ),
    );
  }
}
