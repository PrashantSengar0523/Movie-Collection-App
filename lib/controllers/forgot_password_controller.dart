import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/repository/authentication.dart';

class ForgotPasswordController extends GetxController{
  static ForgotPasswordController get instance=>Get.find();

  final email=TextEditingController();

  void forgotPassword(String email){
    Authentication.instance.resetPasswordWithEmail(email);
  }
}