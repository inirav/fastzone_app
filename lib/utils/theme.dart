import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor = Colors.white;
  static const bgColor = Color(0xFFF6F5F2);
  static const Color redColor = Color(0xffe74c3c);
  static Color greyColor = Colors.grey.shade600;
  static Color lightGreyColor = Colors.grey.withOpacity(0.2);
}


class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.primaryColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: Colors.black87,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.black87, 
        elevation: 1, centerTitle: true, foregroundColor: Colors.white),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: AppColors.redColor),
      textSelectionTheme: const TextSelectionThemeData(cursorColor: AppColors.redColor, 
          selectionColor: AppColors.redColor),
      buttonTheme: const ButtonThemeData(buttonColor: AppColors.redColor),
    );
  }

  static var linkButton = const TextStyle(decoration: TextDecoration.underline);
  static var mainHead = const TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
  static var head1 = const TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
  static var head2 = const TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  static var head3 = const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

}