import 'dart:async';
import 'package:app_book_store/routes/app_routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  splashPage() {
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
      // Navigator.pushReplacement(context,
      //     MaterialPageRoute(builder: (context) => const LoginScreen()));
    });
  }

  @override
  void initState() {
    super.initState();
    splashPage();
  }

  @override
  Widget build(BuildContext context) {
    // Screen dimensions
    final heightsize = MediaQuery.of(context).size.height;
    final widthsize = MediaQuery.of(context).size.width;


    return Scaffold(
      backgroundColor: const Color(0xFFCBD5F0),
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: widthsize * 0.05), // 5% of width
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: heightsize * 0.02), // 2% of height
                Column(
                  children: [
                    // Image/Illustration
                    const Image(
                      image: AssetImage('assets/getstarted_image.png'),
                    ),
                    SizedBox(height: heightsize * 0.06), // 6% of height
                    // Title Text
                    Padding(
                      padding:
                          EdgeInsets.only(left: widthsize * 0.10), // 10% of width
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Read your favourite book from here.',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: widthsize * 0.09, // 9% of width
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF232743),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: heightsize * 0.01), // 1% of height
                    // Subtitle Text
                    Padding(
                      padding:
                          EdgeInsets.only(left: widthsize * 0.1), // 10% of width
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Lorem Ipsum is simply dummy text of the printing and\ntypesetting industry.',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: widthsize * 0.03, // 3% of width
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 40,
                ),

                Column(
                  children: [
                    // Loading Spinner
                    const CircularProgressIndicator(
                      color: Color(0xFF232743),
                    ),
                    SizedBox(height: heightsize * 0.02), // 2% of height
                    // Loading text
                    Text(
                      'Loading...',
                      style: TextStyle(
                        fontSize: widthsize * 0.04, // 4% of width
                        color: const Color(0xFF232743),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: heightsize * 0.02), // 2% of height
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
