// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

import 'package:task_manager/src/design/colors.dart';

class CustomSelect extends StatefulWidget {
  final List<String> elements;
  final String title;
  Function(String) onChange;
  bool reset;

  CustomSelect(
      {this.reset = false,
      required this.elements,
      required this.title,
      required this.onChange,
      Key? key})
      : super(key: key);

  @override
  State<CustomSelect> createState() => _CustomSelectState();
}

class _CustomSelectState extends State<CustomSelect> {
  String? selected;

  @override
  void didUpdateWidget(covariant CustomSelect oldWidget) {
    if (widget.reset == true) {
      setState(() {
        selected = null;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 2.5,
        top: 2.5,
      ),
      margin: const EdgeInsets.only(bottom: 20),
      child: Container(
        height: 50,
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.09),
              offset: const Offset(0, 6),
              blurRadius: 6,
            ),
          ],
        ),
        child: DropdownButton(
          iconEnabledColor: AppColors.primaryColor,
          hint: Text(
            widget.title,
            style: const TextStyle(
              color: AppColors.placeholderColor,
            ),
          ),
          underline: const SizedBox(),
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 36.0,
          isExpanded: true,
          value: selected,
          onChanged: (value) {
            FocusScope.of(context).requestFocus(FocusNode());
            setState(() {
              selected = value.toString();
            });

            widget.onChange(value.toString());
          },
          items: widget.elements.map((ele) {
            return DropdownMenuItem(
              child: Text(ele),
              value: ele,
            );
          }).toList(),
        ),
      ),
    );
  }
}
