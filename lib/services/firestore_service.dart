import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_book_store/models/book.dart';

class FirestoreService {
  // Fetch books from Firestore
  Stream<List<Book>> fetchBooksByCategory() {
    return FirebaseFirestore.instance
        .collection('books') // The name of your Firestore collection
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Book(
          id: doc.id,
          title: doc['title'] as String,
          author: doc['author'] as String,
          price: doc['price'] as double,
          description: doc['description'] as String,
        );
      }).toList();
    });
  }
}

  // Fetch products by category
//   Stream<List<Product>> fetchProductsByCategory(String category) {
//     return FirebaseFirestore.instance
//         .collection('products')
//         .where('categories', arrayContains: category)
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs.map((doc) {
//         return Product.fromJson(doc.data() as Map<String, dynamic>);
//       }).toList();
//     });
//   }
// }

