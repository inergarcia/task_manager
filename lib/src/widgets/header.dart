import 'package:flutter/material.dart';

import 'package:task_manager/src/design/colors.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  const CustomHeader({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 60,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(
            30,
          ),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
