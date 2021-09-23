import 'package:flutter/material.dart';

import 'package:task_manager/src/design/colors.dart';

class ButtonFill extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  final Color color;
  final Color textColor;
  final bool inProcces;

  const ButtonFill({
    this.inProcces = false,
    this.textColor = Colors.white,
    this.color = Colors.white,
    required this.text,
    required this.onPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Material(
        color: color,
        child: InkWell(
          splashColor: AppColors.primaryColor.withOpacity(.7),
          onTap: !inProcces ? onPress : null,
          child: SizedBox(
            width: double.infinity,
            height: 55,
            child: Center(
              child: !inProcces
                  ? Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: textColor,
                      ),
                    )
                  : CircularProgressIndicator(
                      color: textColor,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
