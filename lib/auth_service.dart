import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';  // Firestore for storing the username

class AuthService {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> createUserWithEmailAndPassword(String email, String username, String password) async {
    try {
      // Create user with email and password
      final UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = cred.user;

      // Check if user is created successfully, then store username in Firestore
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'username': username,
          'email': email,
        });
      }

      return user;
    } on FirebaseAuthException catch (e) {
      // Log specific Firebase Auth errors
      log("Firebase Auth Error: ${e.message}");
      rethrow; // Rethrow the error to handle in SignupPage
    } catch (e) {
      log("Error: $e");
      return null;
    }
  }

  Future<User?> loginUserWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return cred.user;
    } on FirebaseAuthException catch (e) {
      log("Firebase Auth Error: ${e.message}");
      rethrow; // Rethrow the error to handle in LoginPage
    } catch (e) {
      log("Error: $e");
      return null;
    }
  }

  Future<void> signout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("Error: $e");
    }
  }
}
