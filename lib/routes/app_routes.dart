import 'package:app_book_store/screens/categoryscreen.dart';
import 'package:app_book_store/screens/signupScreen.dart';
import 'package:flutter/material.dart';
import 'package:app_book_store/screens/loginScreen.dart';
import 'package:app_book_store/screens/mainScreen.dart';
import 'package:app_book_store/screens/forgotpasswordScreen.dart';
import 'package:app_book_store/admin/addBooks.dart';
import 'package:app_book_store/admin/book_listing.dart';
import 'package:app_book_store/admin/updateBooks.dart';
import 'package:app_book_store/admin/userAccounts.dart';

class AppRoutes {
  static const String login = '/login';
  static const String main = '/main';
  static const String forgetpassword = '/forgetpassword';
  static const String signup = '/signup';
  static const String category = '/category';
  static const String addbooks = '/addbooks';
  static const String booklisting = '/booklisting';
  static const String updatebooks = '/updatebooks';
  static const String userAccount = '/userAccounts';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case main:
        return MaterialPageRoute(builder: (_) => MainScreen());
      case forgetpassword:
        return MaterialPageRoute(builder: (_) => ForgotpasswordScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case category:
        return MaterialPageRoute(builder: (_) => CategoryScreen());
      case addbooks:
        return MaterialPageRoute(builder: (_) => AddBookPage());
      case booklisting:
        return MaterialPageRoute(builder: (_) => BookListPage());
      case userAccount:
        // Ensure `settings.arguments` contains the required `userId`
        if (settings.arguments != null && settings.arguments is String) {
          final userId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (_) => UserAccountPage(userId: userId),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('Missing userId for UserAccountPage route'),
              ),
            ),
          );
        }

      case updatebooks:
        // Ensure `settings.arguments` contains the required `data`
        if (settings.arguments != null && settings.arguments is Map) {
          final data = settings.arguments as Map;
          return MaterialPageRoute(
            builder: (_) => UpdateBooks(data: data),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(child: Text('Missing data for UpdateBooks route')),
            ),
          );
        }

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
