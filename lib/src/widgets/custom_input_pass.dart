import 'package:flutter/material.dart';

import 'package:task_manager/src/design/colors.dart';

// ignore: must_be_immutable
class CustomInputPass extends StatefulWidget {
  String placeholder;
  TextEditingController textController;
  TextInputType keywordType;
  bool isPassword;

  CustomInputPass({
    Key? key,
    required this.placeholder,
    required this.textController,
    this.keywordType = TextInputType.text,
    this.isPassword = true,
  }) : super(key: key);

  @override
  _CustomInputPassState createState() => _CustomInputPassState();
}

class _CustomInputPassState extends State<CustomInputPass> {
  bool showPass = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 2.5, top: 2.5, left: 20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: AppColors.imputTextBackgroundColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.09),
            offset: const Offset(0, 6),
            blurRadius: 6,
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.textController,
        cursorColor: AppColors.primaryColor,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: AppColors.inputFontColor,
        ),
        autocorrect: false,
        keyboardType: widget.keywordType,
        obscureText: widget.isPassword,
        decoration: InputDecoration(
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: widget.placeholder,
          hintStyle: const TextStyle(
            color: AppColors.placeholderColor,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                showPass = !showPass;
                widget.isPassword = !widget.isPassword;
              });
            },
            icon: Icon(
              showPass ? Icons.visibility_off : Icons.visibility,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
