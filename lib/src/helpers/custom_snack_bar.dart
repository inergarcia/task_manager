import 'package:flutter/material.dart';

class CustomSnackBar {
  static void showSnakBar({
    required BuildContext context,
    required String msg,
    required Color bgcolor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        elevation: 3,
        backgroundColor: bgcolor,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 30, left: 10, right: 10),
      ),
    );
  }
}
