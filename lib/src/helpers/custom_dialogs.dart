import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

import 'package:task_manager/src/design/colors.dart';
import 'package:task_manager/src/helpers/anim_dialog.dart';

class CustomDialogs {
  static Future<void> showAlertDialog({
    required String title,
    required String msg,
    required BuildContext context,
  }) async {
    await AnimatedDialog.openCustomDialog(
      context: context,
      dismissible: true,
      child: AlertDialog(
        backgroundColor: AppColors.background,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        content: Text(
          msg,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  static Future<void> showAlertDialogWihtCancel({
    required String title,
    required String msg,
    required BuildContext context,
    required VoidCallback onPress,
  }) async {
    await AnimatedDialog.openCustomDialog(
      context: context,
      dismissible: true,
      child: AlertDialog(
        backgroundColor: AppColors.background,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        content: Text(msg,
            style: const TextStyle(
              color: Colors.black,
            )),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: onPress,
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  static Future<void> showLoadingDialog({required BuildContext context}) async {
    await showAnimatedDialog(
      barrierColor: Colors.transparent,
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: FloatingActionButton(
            onPressed: () {},
            child: const CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        );
      },
      animationType: DialogTransitionType.fade,
      curve: Curves.easeInOut,
      duration: const Duration(seconds: 1),
    );
  }
}
