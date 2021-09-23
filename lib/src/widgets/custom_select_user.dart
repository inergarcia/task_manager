import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:task_manager/src/design/colors.dart';
import 'package:task_manager/src/models/user.dart';
import 'package:task_manager/src/providers/task.dart';

class CustomSelectUser extends StatefulWidget {
  final List<User>? users;
  final String title;

  const CustomSelectUser({required this.users, required this.title, Key? key})
      : super(key: key);

  @override
  State<CustomSelectUser> createState() => _CustomSelectUserState();
}

class _CustomSelectUserState extends State<CustomSelectUser> {
  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of<TaskProvider>(context);

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
          value: taskProvider.selectedResponsable,
          onChanged: (User? user) {
            FocusScope.of(context).requestFocus(FocusNode());
            taskProvider.selectedResponsable = user;
          },
          items: widget.users!.map((user) {
            return DropdownMenuItem(
              child: Text(user.username),
              value: user,
            );
          }).toList(),
        ),
      ),
    );
  }
}
