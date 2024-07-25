import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/repository/authentication.dart';

class LoginController extends GetxController{
  static LoginController get instance=>Get.find();

  final email=TextEditingController();
  final password=TextEditingController();

  void loginUser(String email,String password){
    Authentication.instance.loginUserWithEmailAndPassword(email, password);
  }

   @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}