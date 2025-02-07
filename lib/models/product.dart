import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        images: List<String>.from(json['image']),
        categories: List<String>.from(json['categories']),
        price: json['price'].toDouble(),
        rating: json['rating'].toDouble(),
      );
  toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'image': images,
        'categories': categories,
        'price': price,
        'rating': rating,
      };
}

List<Product> productsFromJson(List json) {
  return List<Product>.from(json.map((x) => Product.fromJson(x.data())));
}

final List<Product> products = [];
// Our demo Products
// List<Product> products = [
//   Product(
//     id: 1,
//     images: ['https://i.postimg.cc/VdWs58LC/01.jpg'],
//     title: 'Beserk',
//     description: 'This is the description for product 1.',
//     categories: ['Technology', 'Design'],
//     price: 780.0,
//   ),
//   Product(
//     id: 2,
//     images: ['https://i.postimg.cc/Yv2rWshy/03.jpg'],
//     title: 'The Adventure',
//     description: 'This is the description for product 2.',
//     categories: ['Innovation', 'Business'],
//     price: 850.0,
//   ),
//   Product(
//     id: 3,
//     images: ['https://i.postimg.cc/wyNgzKG3/05.jpg'],
//     title: 'Saint',
//     description: 'This is the description for product 3.',
//     categories: ['Technology', 'Design'],
//     price: 900.0,
//   ),
//   Product(
//     id: 4,
//     images: ['https://i.postimg.cc/yJts26nw/06.jpg'],
//     title: 'Fallout',
//     description: 'This is the description for product 4.',
//     categories: ['Innovation', 'Business'],
//     price: 950.0,
//   ),
//   Product(
//     id: 5,
//     images: ['https://i.postimg.cc/tntb13yj/07.jpg'],
//     title: 'The Lost Trip',
//     description: 'This is the description for product 5.',
//     categories: ['Technology', 'Design'],
//     price: 1000.0,
//   ),
//   Product(
//     id: 6,
//     images: ['https://i.postimg.cc/jDkbJdVL/08.jpg'],
//     title: 'Dark',
//     description: 'This is the description for product 6.',
//     categories: ['Innovation', 'Business'],
//     price: 1050.0,
//   ),
//   Product(
//     id: 7,
//     images: ['https://i.postimg.cc/MM1247nQ/09.jpg'],
//     title: 'My First Love',
//     description: 'This is the description for product 7.',
//     categories: ['Technology', 'Design'],
//     price: 1100.0,
//   ),
//   Product(
//     id: 8,
//     images: ['https://i.postimg.cc/LgRKMJP0/10.jpg'],
//     title: 'My Little Life',
//     description: 'This is the description for product 8.',
//     categories: ['Innovation', 'Business'],
//     price: 1150.0,
//   ),
//   Product(
//     id: 9,
//     images: ['https://i.postimg.cc/nMtCLTYN/11.jpg'],
//     title: 'Gone With The Wind',
//     description: 'This is the description for product 9.',
//     categories: ['Technology', 'Design'],
//     price: 1200.0,
//   ),
//   Product(
//     id: 10,
//     images: ['https://i.postimg.cc/sGcFf39f/12.jpg'],
//     title: 'Money Power',
//     description: 'This is the description for product 10.',
//     categories: ['Innovation', 'Business'],
//     price: 1250.0,
//   ),
//   Product(
//     id: 11,
//     images: ['https://i.postimg.cc/V5B50MKv/13.png'],
//     title: 'A Novel View Of British History',
//     description: 'This is the description for product 11.',
//     categories: ['Technology', 'Design'],
//     price: 1300.0,
//   ),
//   Product(
//     id: 12,
//     images: ['https://i.postimg.cc/F7rzyR6Z/14.png'],
//     title: 'The Alien',
//     description: 'This is the description for product 12.',
//     categories: ['Innovation', 'Business'],
//     price: 1350.0,
//   ),
//   Product(
//     id: 13,
//     images: ['https://i.postimg.cc/mtmD84fG/15.png'],
//     title: 'My Lovely Wife',
//     description: 'This is the description for product 13.',
//     categories: ['Technology', 'Design'],
//     price: 1400.0,
//   ),
//   Product(
//     id: 14,
//     images: ['https://i.postimg.cc/Wdt4yyTq/16.png'],
//     title: 'The Lords Of The Rings',
//     description: 'This is the description for product 14.',
//     categories: ['Innovation', 'Business'],
//     price: 1450.0,
//   ),
//   Product(
//     id: 15,
//     images: ['https://i.postimg.cc/68SQxhpj/17.png'],
//     title: 'Black & White',
//     description: 'This is the description for product 15.',
//     categories: ['Technology', 'Design'],
//     price: 1500.0,
//   ),
//   Product(
//     id: 16,
//     images: ['https://i.postimg.cc/p9FLWn92/18.jpg'],
//     title: 'Find Me',
//     description: 'This is the description for product 16.',
//     categories: ['Innovation', 'Business'],
//     price: 1550.0,
//   ),
// ];
