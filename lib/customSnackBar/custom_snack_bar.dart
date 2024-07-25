import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TGetSnackBar {
  static void show(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black54,
      colorText: Colors.white,
    );
  }
}
