// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:task_manager/src/design/colors.dart';
import 'package:task_manager/src/helpers/date.dart';

class CustomInputDate extends StatefulWidget {
  Function(DateTime) onChange;
  CustomInputDate({required this.onChange, Key? key}) : super(key: key);

  @override
  State<CustomInputDate> createState() => _CustomInputDateState();
}

class _CustomInputDateState extends State<CustomInputDate> {
  late String selectDate;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectDate = DateTime.now().toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 2.5,
        top: 2.5,
        left: 20,
      ),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            CustomDate.parseMDY(selectDate),
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          TextButton(
            onPressed: () {
              DatePicker.showDatePicker(
                context,
                showTitleActions: true,
                minTime: DateTime.now(),
                maxTime: DateTime(2040, 1, 0),
                onConfirm: (date) {
                  setState(() => selectDate = date.toString());
                  widget.onChange(date);
                },
                currentTime: DateTime.now(),
                locale: LocaleType.en,
              );
            },
            child: const Icon(
              Icons.date_range,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
