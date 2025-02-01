// import 'package:app_book_store/services/firestore_service.dart';
class Product {
  final int id;
  final String title, description;
  final List<String> images;
  final List<String> categories;
  final bool isFavourite, isPopular;
  final double price;
  final double rating;

  Product({
    required this.id,
    required this.images,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
    required this.categories,
  });
}

// Our demo Products
List<Product> products = [
  Product(
    id: 1,
    images: ['https://i.postimg.cc/VdWs58LC/01.jpg'],
    title: 'Product 1',
    description: 'This is the description for product 1.',
    categories: ['Technology', 'Design'],
    price: 780.0,
  ),
  Product(
    id: 2,
    images: ['https://i.postimg.cc/Yv2rWshy/03.jpg'],
    title: 'Product 2',
    description: 'This is the description for product 2.',
    categories: ['Innovation', 'Business'],
    price: 850.0,
  ),
  Product(
    id: 3,
    images: ['https://i.postimg.cc/wyNgzKG3/05.jpg'],
    title: 'Product 3',
    description: 'This is the description for product 3.',
    categories: ['Technology', 'Design'],
    price: 900.0,
  ),
  Product(
    id: 4,
    images: ['https://i.postimg.cc/yJts26nw/06.jpg'],
    title: 'Product 4',
    description: 'This is the description for product 4.',
    categories: ['Innovation', 'Business'],
    price: 950.0,
  ),
  Product(
    id: 5,
    images: ['https://i.postimg.cc/tntb13yj/07.jpg'],
    title: 'Product 5',
    description: 'This is the description for product 5.',
    categories: ['Technology', 'Design'],
    price: 1000.0,
  ),
  Product(
    id: 6,
    images: ['https://i.postimg.cc/jDkbJdVL/08.jpg'],
    title: 'Product 6',
    description: 'This is the description for product 6.',
    categories: ['Innovation', 'Business'],
    price: 1050.0,
  ),
  Product(
    id: 7,
    images: ['https://i.postimg.cc/MM1247nQ/09.jpg'],
    title: 'Product 7',
    description: 'This is the description for product 7.',
    categories: ['Technology', 'Design'],
    price: 1100.0,
  ),
  Product(
    id: 8,
    images: ['https://i.postimg.cc/LgRKMJP0/10.jpg'],
    title: 'Product 8',
    description: 'This is the description for product 8.',
    categories: ['Innovation', 'Business'],
    price: 1150.0,
  ),
  Product(
    id: 9,
    images: ['https://i.postimg.cc/nMtCLTYN/11.jpg'],
    title: 'Product 9',
    description: 'This is the description for product 9.',
    categories: ['Technology', 'Design'],
    price: 1200.0,
  ),
  Product(
    id: 10,
    images: ['https://i.postimg.cc/sGcFf39f/12.jpg'],
    title: 'Product 10',
    description: 'This is the description for product 10.',
    categories: ['Innovation', 'Business'],
    price: 1250.0,
  ),
  Product(
    id: 11,
    images: ['https://i.postimg.cc/V5B50MKv/13.png'],
    title: 'Product 11',
    description: 'This is the description for product 11.',
    categories: ['Technology', 'Design'],
    price: 1300.0,
  ),
  Product(
    id: 12,
    images: ['https://i.postimg.cc/F7rzyR6Z/14.png'],
    title: 'Product 12',
    description: 'This is the description for product 12.',
    categories: ['Innovation', 'Business'],
    price: 1350.0,
  ),
  Product(
    id: 13,
    images: ['https://i.postimg.cc/mtmD84fG/15.png'],
    title: 'Product 13',
    description: 'This is the description for product 13.',
    categories: ['Technology', 'Design'],
    price: 1400.0,
  ),
  Product(
    id: 14,
    images: ['https://i.postimg.cc/Wdt4yyTq/16.png'],
    title: 'Product 14',
    description: 'This is the description for product 14.',
    categories: ['Innovation', 'Business'],
    price: 1450.0,
  ),
  Product(
    id: 15,
    images: ['https://i.postimg.cc/68SQxhpj/17.png'],
    title: 'Product 15',
    description: 'This is the description for product 15.',
    categories: ['Technology', 'Design'],
    price: 1500.0,
  ),
  Product(
    id: 16,
    images: ['https://i.postimg.cc/p9FLWn92/18.jpg'],
    title: 'Product 16',
    description: 'This is the description for product 16.',
    categories: ['Innovation', 'Business'],
    price: 1550.0,
  ),
];
// class Product {
//   final int id;
//   final String title, description;
//   final List<String> images;
//   final List<String> categories;
//   final bool isFavourite, isPopular;
//   final double price;
//   final double rating;

//   Product({
//     required this.id,
//     required this.images,
//     this.rating = 0.0,
//     this.isFavourite = false,
//     this.isPopular = false,
//     required this.title,
//     required this.price,
//     required this.description,
//     required this.categories,
//   });

  // fromFirestore method to convert Firestore data to Product object
  // factory roduct.fromFirestore(Map<String, dynamic> doc, String id) {
  //   return Product(
  //     id: int.parse(id), // Assuming `id` is a string in Firestore
  //     title: doc['title'] ?? '',
  //     description: doc['description'] ?? '',
  //     images: List<String>.from(doc['images'] ?? []),
  //     categories: List<String>.from(doc['categories'] ?? []),
  //     price: doc['price']?.toDouble() ?? 0.0,
  //     rating: doc['rating']?.toDouble() ?? 0.0,
  //     isFavourite: doc['isFavourite'] ?? false,
  //     isPopular: doc['isPopular'] ?? false,
  //   );
  // }

