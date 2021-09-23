import 'package:flutter/material.dart';

import 'package:task_manager/src/design/colors.dart';

class CustomInput extends StatefulWidget {
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keywordType;
  final bool isPassword;
  final int maxLines;

  const CustomInput({
    Key? key,
    required this.placeholder,
    required this.textController,
    this.keywordType = TextInputType.text,
    this.isPassword = false,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool showIcon = false;

  @override
  void didUpdateWidget(covariant CustomInput oldWidget) {
    if (widget.textController.text.isEmpty) {
      setState(() {
        showIcon = false;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.maxLines != 1 ? null : 50,
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
        maxLines: widget.maxLines,
        onChanged: (String value) {
          if (value.isNotEmpty) {
            setState(() {
              showIcon = true;
            });
          } else {
            setState(() {
              showIcon = false;
            });
          }
        },
        controller: widget.textController,
        cursorColor: AppColors.primaryColor,
        style: const TextStyle(
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
          suffixIcon: getIcon(),
        ),
      ),
    );
  }

  Widget? getIcon() {
    if (showIcon) {
      return IconButton(
        onPressed: () {
          widget.textController.clear();
          setState(() {
            showIcon = false;
          });
        },
        icon: const Icon(
          Icons.cancel,
          color: AppColors.primaryColor,
        ),
      );
    }
    return null;
  }
}
