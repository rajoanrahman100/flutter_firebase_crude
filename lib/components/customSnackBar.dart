import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackBar {

  static void showSnackBar({required BuildContext? context, required String title, required String message, required
  Color backColor}) {
    Get.snackbar(
        title, message, snackPosition: SnackPosition.BOTTOM, backgroundColor: backColor, colorText: Colors.green);
  }

}