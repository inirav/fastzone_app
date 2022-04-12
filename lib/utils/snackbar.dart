import 'package:fastzone/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackBar {
  static defaultSnackBar({
    required String title, 
    required String message,
    bool showInCenter = false,
    Color backgroundColor = Colors.white,
    Color titleColor = AppColors.redColor,
    Color messageColor = AppColors.redColor,
    SnackPosition snackPosition = SnackPosition.TOP,
    double borderRadius = 10.0,
    // Function(GetBar<Object>)? onTap,
    required int duration,
    }) {
      Get.snackbar(
      '',
      '',
      titleText: Text(
        title,
        textAlign: showInCenter ? TextAlign.center : TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: titleColor,
          fontSize: 17,
        ),
      ),
      messageText: Text(
        message,
        textAlign: showInCenter ? TextAlign.center : TextAlign.left,
        style: TextStyle(
          color: messageColor,
        ),
      ),
      backgroundColor: backgroundColor,
      margin: const EdgeInsets.all(10),
      snackPosition: snackPosition,
      borderRadius: borderRadius,
      duration: Duration(seconds: duration),
      // barBlur: 20.0,
      // onTap: onTap,
      reverseAnimationCurve: Curves.fastLinearToSlowEaseIn,
    );
  }



}
