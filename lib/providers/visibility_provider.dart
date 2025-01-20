import 'package:flutter/material.dart';

class VisibilityProvider extends ChangeNotifier {
  bool _isVisible = true;

  // Getter for _isVisible
  bool get isVisible => _isVisible;

  // Method to toggle visibility
  void changeVisibility() {
    _isVisible = !_isVisible;
    notifyListeners();
  }
}
