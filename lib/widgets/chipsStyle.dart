//Chips styling based on category starts here
import 'package:flutter/material.dart';

TextStyle getCategoryTextStyle(String category) {
  switch (category) {
    case 'Technology':
      return TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.orange,
      );
    case 'Design':
      return TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.red,
      );
    case 'Innovation':
      return TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.deepPurple,
      );
    case 'Business':
      return TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.green,
      );
    case 'Marketing':
      return TextStyle(
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 3, 88, 158),
      );
    default:
      return TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
      );
  }
}

Color getCategoryBackgroundColor(String category) {
  switch (category) {
    case 'Technology':
      return Color.fromARGB(99, 255, 153, 0);
    case 'Design':
      return Color.fromARGB(99, 255, 82, 82);
    case 'Innovation':
      return Color.fromARGB(99, 155, 39, 176);
    case 'Business':
      return Color.fromARGB(99, 139, 195, 74);
    case 'Marketing':
      return Color.fromARGB(99, 33, 149, 243);
    default:
      return Colors.grey;
  }
}

//Chips styling based on category ends here
