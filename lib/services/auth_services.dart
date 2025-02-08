import 'package:app_book_store/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        '90193292655-sdpdgg6d0b6j00di2lc6psn0hubprca4.apps.googleusercontent.com',
  );

  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return null; // User canceled the sign-in
      }

      // Obtain the authentication details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential for Firebase
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credentials
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Check if the user is successfully signed in
      if (userCredential.user != null) {
        // Navigate to the MainScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      }

      // Return the signed-in user
      return userCredential.user;
    } catch (e) {
      print("Error during Google Sign-In: $e");
      return null;
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      // First, sign out from Google
      await _googleSignIn.signOut();
      print('Google sign-out successful');

      // Then, sign out from Firebase
      await FirebaseAuth.instance.signOut();
      print('Firebase sign-out successful');

      // Navigate to the login screen
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      print("Error during sign-out: $e");
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Logout failed: ${e.toString()}')));
    }
  }
}
