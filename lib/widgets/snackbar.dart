import 'package:flutter/material.dart';

class Snackbar {
  static SnackBar createSnackBar(String message) {
    return SnackBar(
      action: SnackBarAction(
        label: ' ',
        onPressed: () {
          // Code to execute.
        },
      ),
      content: Text(message),
      width: 280.0, // Width of the SnackBar.
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0, // Inner padding for SnackBar content.
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
