// import 'package:app_book_store/screens/login.dart';
import 'package:app_book_store/providers/orderProvider.dart';
import 'package:app_book_store/providers/productsProvider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// import 'package:app_book_store/screens/splash_screen.dart';
// import 'package:app_book_store/admin/addBooks.dart';
import 'package:provider/provider.dart';
import 'package:app_book_store/providers/user_provider.dart';
import 'package:app_book_store/providers/visibility_provider.dart';
import 'package:app_book_store/routes/app_routes.dart';
import 'package:app_book_store/providers/cartProvider.dart';
// import  'package:app_book_store';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => VisibilityProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => Productsprovider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Book Store App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: AppRoutes.addbooks,
        onGenerateRoute: AppRoutes.generateRoute,
        home: AuthWrapper(),
      ),
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // return AddBookPage();
//   }
// }
