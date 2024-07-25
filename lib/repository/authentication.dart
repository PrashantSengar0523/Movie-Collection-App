import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_app/bottomNavBar/navigation.dart';
import 'package:my_app/customSnackBar/custom_snack_bar.dart';
import 'package:my_app/login&Signup/login_screen.dart';

class Authentication extends GetxController {
  static Authentication get instance => Get.find();
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      debugPrint("No user is signed in, navigating to LoginScreen.");
      Get.offAll(() => const LoginScreen());
    } else {
      debugPrint("User is signed in, navigating to HomeScreen.");
      Get.offAll(() => const NavigationMenu());
    }
  }

  // Create user with email and password
  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    try {
      debugPrint("Starting user creation process...");
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      debugPrint("User creation successful.");

      if (firebaseUser.value != null) {
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.to(() => const LoginScreen());
      }
    } catch (e) {
      String errorMessage;
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
            errorMessage = 'The email address is already in use by another account.';
            break;
          case 'invalid-email':
            errorMessage = 'The email address is not valid.';
            break;
          case 'operation-not-allowed':
            errorMessage = 'Email/password accounts are not enabled.';
            break;
          case 'weak-password':
            errorMessage = 'The password is too weak.';
            break;
          default:
            errorMessage = 'An unknown error occurred. Please try again.';
        }
      } else {
        errorMessage = 'An unknown error occurred. Please try again.';
      }

      debugPrint("Error during user creation: $errorMessage");
      Get.snackbar(
        'Error',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Login user with email
  Future<void> loginUserWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      // Check if the user is logged in and navigate accordingly
      User? user = _auth.currentUser;
      if (user != null) {
        Get.offAll(() => const NavigationMenu());
        Get.snackbar(
          'Logged In',
          'Successfully logged in',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.to(() => const LoginScreen());
        Get.snackbar(
          'Error',
          'Unexpected error. Please try logging in again.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      String errorMessage;
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'invalid-email':
            errorMessage = 'The email address is not valid.';
            break;
          case 'operation-not-allowed':
            errorMessage = 'Email/password accounts are not enabled.';
            break;
          case 'wrong-password':
            errorMessage = 'The password is wrong.';
            break;
          default:
            errorMessage = 'An unknown error occurred. Please try again.';
        }
      } else {
        errorMessage = 'An unknown error occurred. Please try again.';
      }

      Get.snackbar(
        'Error',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Forgot Password
  Future<void> resetPasswordWithEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      TGetSnackBar.show('Success', 'Password reset email sent');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        TGetSnackBar.show('Error', 'No user found for that email');
      } else {
        TGetSnackBar.show('Error', 'Failed to send password reset email: ${e.message}');
      }
    } catch (e) {
      TGetSnackBar.show('Error', 'An unknown error occurred: $e');
    }
  }

  // User logout
  Future<void> userLogout() async {
    await _auth.signOut();
  }

  // Google Sign-In
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw FirebaseAuthException(code: 'CANCELED', message: 'Sign-in canceled by user');
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        Get.offAll(() => const NavigationMenu());
        Get.snackbar(
          'Logged In',
          'Successfully logged in with Google',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      String errorMessage = 'An unknown error occurred. Please try again.';
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'CANCELED':
            errorMessage = 'Sign-in canceled by user';
            break;
          default:
            errorMessage = e.message ?? errorMessage;
        }
      }
      Get.snackbar(
        'Error',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}