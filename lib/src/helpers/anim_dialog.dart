import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class AnimatedDialog {
  static Future<void> openCustomDialog({
    required BuildContext context,
    required Widget child,
    bool dismissible = true,
  }) async {
    await showAnimatedDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (BuildContext context) {
        return child;
      },
      animationType: DialogTransitionType.slideFromTop,
      curve: Curves.easeInOut,
      duration: const Duration(seconds: 1),
    );
  }
}
