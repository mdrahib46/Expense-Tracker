import 'package:flutter/material.dart';

class AppUtils {
  AppUtils._();

  /// For Light Theme
  static  Color earnLightTileColor = Color(0xFFe5f5e0);
  static  Color earnLightFontColor = Color(0xff006d2c);
  static  Color earnLightIconColor = Color(0xff006d2c);

  static Color expenseLightTileColor = Color(0xffffbaba);
  static Color expenseLightFontColor = Color(0xffa70000);
  static Color expenseLightIconColor = Color(0xffa70000);


  /// For Dark Theme
  static Color earnDartTileColor = Color(0xFF1F1B24);
  static Color earnDarkFontColor = Colors.white;
  static Color earnDartIconColor = Colors.white;


  static const TextStyle titleStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.w600);
  static const TextStyle subtitleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w400);



  static void showCustomSnackBar({
    required BuildContext context,
    required String message,
    bool isSuccess = true, // true = success (green), false = error (red)
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: isSuccess ? Colors.green : Colors.red.shade300,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }


}