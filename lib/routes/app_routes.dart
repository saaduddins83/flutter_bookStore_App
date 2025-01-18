import 'package:app_book_store/screens/categoryscreen.dart';
import 'package:app_book_store/screens/signupScreen.dart';
import 'package:flutter/material.dart';
import 'package:app_book_store/screens/loginScreen.dart';
import 'package:app_book_store/screens/mainScreen.dart';
import 'package:app_book_store/screens/forgotpasswordScreen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String main = '/main';
  static const String forgetpassword = '/forgetpassword';
  static const String signup = '/signup';
  static const String category = '/category';

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

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
