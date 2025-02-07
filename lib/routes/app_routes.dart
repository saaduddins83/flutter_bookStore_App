import 'package:app_book_store/screens/categoryscreen.dart';
import 'package:app_book_store/screens/signupScreen.dart';
import 'package:app_book_store/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_book_store/screens/login_screen.dart';
import 'package:app_book_store/screens/main_screen.dart';
import 'package:app_book_store/screens/forgotpasswordScreen.dart';
import 'package:app_book_store/admin/addBooks.dart';
import 'package:app_book_store/admin/book_listing.dart';
import 'package:app_book_store/admin/updateBooks.dart';
import 'package:app_book_store/admin/userAccounts.dart';

class AppRoutes {
  static const String splashscreen = '/splashscreen';
  static const String login = '/login';
  static const String main = '/main';
  static const String forgetpassword = '/forgetpassword';
  static const String signup = '/signup';
  static const String category1 = '/category1';

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
      case category1:
        final searchQuery = settings.arguments as String?;

        return MaterialPageRoute(
            builder: (_) => Categoryscreen(
                  searchQuery: searchQuery,
                ));
      case addbooks:
        return MaterialPageRoute(builder: (_) => AddBookPage());
      case booklisting:
        return MaterialPageRoute(builder: (_) => BookListPage());
      case splashscreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
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
