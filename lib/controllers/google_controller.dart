import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_app/models/user_model.dart';
import 'package:my_app/repository/user_repo.dart';

import '../bottomNavBar/navigation.dart';

class GoogleSignInController extends GetxController {
  static GoogleSignInController get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '1046336679588-snst20aj2tkpi1un21228nlln1g29sc2.apps.googleusercontent.com', // Replace with your actual client ID
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  // Method to handle Google Sign-In
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
        debugPrint("User signed in with Google: ${user.displayName}");
        await _storeUserInfo(user);
        Get.offAll(() => const NavigationMenu());
        Get.snackbar(
          'Logged In',
          'Successfully logged in with Google',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      debugPrint("Error during Google Sign-In: $e");
      Get.snackbar(
        'Error',
        'Failed to sign in with Google: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Store user info in Firestore
  Future<void> _storeUserInfo(User user) async {
    final userModel = UserModel(
      id: user.uid,
      email: user.email ?? '',
      firstName: user.displayName?.split(' ').first ?? '',
      lastName: user.displayName?.split(' ').last ?? '',
      phone: '', // You might want to gather this info separately
      profileImage: user.photoURL ?? 'https://i.postimg.cc/TPXSTpw6/user.png',
    );
    debugPrint("Storing user info in Firestore...");
    await UserRepo.instance.createUser(userModel);
  }
}
