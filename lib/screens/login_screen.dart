import 'package:app_book_store/providers/visibility_provider.dart';
import 'package:app_book_store/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_book_store/widgets/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:sign_button/sign_button.dart';
import 'package:app_book_store/routes/app_routes.dart';
// import 'package:app_book_store/screens/signupScreen.dart';

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
      Navigator.pushNamed(context, AppRoutes.main);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text('Email',
                      style: TextStyle(
                        fontSize: 16,
                      )),
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),

                    // hintText: 'Email',
                    // label: Text(
                    //   'Email',
                    // ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                Consumer<VisibilityProvider>(
                  builder: (context, provider, child) {
                    return TextFormField(
                      controller: _passwordController,
                      obscureText: provider.isVisible,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            provider.changeVisibility();
                          },
                          child: Icon(
                            provider.isVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    );
                  },
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,

                      // Make the button as wide as its parent
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 237, 86, 132),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        onPressed: _login,
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AppRoutes.forgetpassword);
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
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            'OR',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                // Divider with padding ends here

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Center(
                        child: SignInButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          buttonType: ButtonType.google,
                          onPressed: () async {
                            final user =
                                await AuthService().signInWithGoogle(context);
                            if (user != null) {
                              // Successfully signed in
                              // print("Signed in as: ${user.displayName}");
                              ScaffoldMessenger.of(context).showSnackBar(
                                Snackbar.createSnackBar("SignUp Successful"),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.signup);
                        },
                        child: const Text('Need An Account? SignUp here'),
                      ),
                    ),
                  ],
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
