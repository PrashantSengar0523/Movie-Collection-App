import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/customSnackBar/custom_snack_bar.dart';
import 'package:my_app/models/user_model.dart';
import 'package:my_app/repository/authentication.dart';

class UserRepo extends GetxController {
  static UserRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    debugPrint("Creating user in Firestore...");
    debugPrint("User ID: ${user.id}");
    debugPrint("User Email: ${user.email}");
    debugPrint("User First Name: ${user.firstName}");
    debugPrint("User Last Name: ${user.lastName}");
    debugPrint("User Phone: ${user.phone}");
    debugPrint("User Profile Image: ${user.profileImage}"); // Check if profileImage is correctly set

    try {
      await _db
          .collection("Users")
          .doc(user.id)  // Use the UID as the document ID
          .set(user.toJson())
          .whenComplete(() {
            debugPrint("User info stored successfully.");
            TGetSnackBar.show("Success", "Your account has been created");
          });
    } catch (error, stackTrace) {
      debugPrint("Error storing user info: $error");
      debugPrint("Stack trace: $stackTrace");
      TGetSnackBar.show("Error", "Something went wrong");
      debugPrint(error.toString());
    }
  }

  Future<UserModel?> retrieveUserDetail() async {
    final User? currentUser = Authentication.instance.firebaseUser.value;

    if (currentUser != null) {
      String userId = currentUser.uid;

      try {
        DocumentSnapshot doc = await _db.collection("Users").doc(userId).get();
        if (doc.exists) {
          return UserModel.fromMap(doc.data() as Map<String, dynamic>);
        } else {
          debugPrint("No such user!");
          return null;
        }
      } catch (error) {
        debugPrint("Error retrieving user details: $error");
        return null;
      }
    } else {
      debugPrint("No user is currently logged in.");
      return null;
    }
  }

 Future<void> updateUserDetail(UserModel user) async {
    final User? currentUser = Authentication.instance.firebaseUser.value;

    if (currentUser != null) {
      String userId = currentUser.uid;

      try {
        await _db.collection("Users").doc(userId).update(user.toJson());
        debugPrint("User details updated successfully.");
      } catch (e) {
        debugPrint("Error updating user details: $e");
        throw 'Something went wrong';
      }
    } else {
      debugPrint("No user is currently logged in.");
    }
  }
}