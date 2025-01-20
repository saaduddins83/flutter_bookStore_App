class Book {
  final String id;
  final String title;
  final String author;
  final double price;
  final String description;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.price,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'price': price,
      'description': description,
    };
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
    );
  }
}
