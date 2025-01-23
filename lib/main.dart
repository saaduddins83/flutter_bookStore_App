// import 'package:app_book_store/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// import 'package:app_book_store/screens/splash_screen.dart';
// import 'package:app_book_store/admin/addBooks.dart';
import 'package:provider/provider.dart';
import 'package:app_book_store/providers/user_provider.dart';
import 'package:app_book_store/providers/visibility_provider.dart';
import 'package:app_book_store/routes/app_routes.dart';
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => VisibilityProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: AppRoutes.userAccount,
        onGenerateRoute: AppRoutes.generateRoute,
        // home: const MyHomePage(),
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
