import 'package:app_book_store/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_book_store/widgets/snackbar.dart';
import 'package:sign_button/sign_button.dart';
import 'package:app_book_store/routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _login() async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _usernameController.text, password: _passwordController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        Snackbar.createSnackBar("Login Successful"),
      );
      Navigator.pushNamed(context, AppRoutes.category);
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => const MainScreen()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        Snackbar.createSnackBar("Login Failed: ${e.toString()}"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 109, 154, 196),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(30),
          elevation: 5,
          // padding: EdgeInsets.all(20),
          // width: 400,
          // constraints: BoxConstraints(maxWidth: 700),
          // decoration: BoxDecoration(
          //   color: Colors.white,
          //   borderRadius: BorderRadius.circular(10),
          // ),
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    label: Text(
                      'Email',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    label: Text('Password'),
                  ),
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.forgetpassword);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) =>
                        //           const ForgotpasswordScreen()),
                        // );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey, // Text color
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text('Forgot Password?'),
                    )),
                Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.signup);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const SignupScreen()),
                        // );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey, // Text color
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text('Don\'t have an account? Sign up here'),
                    )),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _login,
                  child: const Text('Login'),
                ),
                SizedBox(height: 10),
                Text(
                  'Or',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 10),
                SignInButton(
                  buttonType: ButtonType.google,
                  onPressed: () async {
                    final user = await AuthService().signInWithGoogle(context);
                    if (user != null) {
                      // Successfully signed in
                      print("Signed in as: ${user.displayName}");
                    } else {
                      // Sign-in failed or canceled
                      print("Google Sign-In failed");
                    }
                  },
                ),
                // ElevatedButton(
                //   onPressed: () async {
                //     final user =
                //         await AuthService().signInWithGoogle(context);
                //     if (user != null) {
                //       // Successfully signed in
                //       print("Signed in as: ${user.displayName}");
                //     } else {
                //       // Sign-in failed or canceled
                //       print("Google Sign-In failed");
                //     }
                //   },
                //   child: Text('Sign in with Google'),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
