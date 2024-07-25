import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_app/models/user_model.dart';
import 'package:my_app/repository/authentication.dart';
import 'package:my_app/repository/user_repo.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final password = TextEditingController();
  final phone = TextEditingController();

  void registerUser() async {
    debugPrint("Starting user registration...");
    try {
      // Perform Email Auth
      await Authentication.instance.createUserWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Storing User Info if authentication is successful
      if (Authentication.instance.firebaseUser.value != null) {
        final user = UserModel(
          id: Authentication.instance.firebaseUser.value!.uid,
          email: email.text.trim(),
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          phone: phone.text.trim(),
          profileImage: 'https://i.postimg.cc/TPXSTpw6/user.png',
        );
        debugPrint("User authenticated, storing user info...");
        await storeUserInfo(user);
      } else {
        debugPrint("User authentication failed.");
      }
    } catch (e) {
      debugPrint("Error during user registration: $e");
    }
  }

  Future<void> storeUserInfo(UserModel user) async {
    debugPrint("Storing user info in Firestore...");
    await UserRepo.instance.createUser(user);
  }
}
