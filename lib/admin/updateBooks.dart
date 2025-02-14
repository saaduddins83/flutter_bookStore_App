import 'package:app_book_store/admin/floatingActionButton.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_book_store/models/product.dart';

class UpdateBooks extends StatefulWidget {
  final dynamic data; // Pass the book document ID or data
  const UpdateBooks({super.key, required this.data});

  @override
  State<UpdateBooks> createState() => _UpdateBooksState();
}

class _UpdateBooksState extends State<UpdateBooks> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-fill the form fields with existing data
    _titleController.text = widget.data['title'];
    _imageController.text = widget.data['images']?[0] ?? '';
    _priceController.text = widget.data['price'].toString();
    _descriptionController.text = widget.data['description'];
    _ratingController.text = widget.data['rating']?.toString() ?? '';
  }

  Future<void> _updateBook() async {
    if (_formKey.currentState!.validate()) {
      try {
        final firestore = FirebaseFirestore.instance;

        // Collect updated book data
        final updatedProduct = Product(
          id: widget.data['id'],
          title: _titleController.text,
          categories: widget.data['categories'] ?? ['Technology', 'Design'],
          images: [_imageController.text],
          rating: double.parse(_ratingController.text),
          price: double.parse(_priceController.text),
          description: _descriptionController.text,
        );

        // Update the book in Firestore using the document ID
        await firestore
            .collection('products')
            .doc(widget.data['id'])
            .set(updatedProduct.toJson());

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Book updated successfully!')),
        );

        // Navigate back to the previous screen
        Navigator.pop(context);
      } catch (e) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update book: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Book'),
        backgroundColor: Colors.teal,
        centerTitle: true,
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

                // Image URL Field
                _buildTextField(
                  controller: _imageController,
                  label: 'Image URL',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the image URL';
                    }
                    return null;
                  },
                ),

                // Rating Field
                _buildTextField(
                  controller: _ratingController,
                  label: 'Rating',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the rating';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
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
                      return 'Please enter the description';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Update Book Button
                ElevatedButton(
                  onPressed: _updateBook,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Update Book',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: NavigationFAB(),
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
