import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:task_manager/src/design/colors.dart';
import 'package:task_manager/src/models/task.dart';
import 'package:task_manager/src/providers/task.dart';

// ignore: must_be_immutable
class CustomSelectTask extends StatefulWidget {
  final String title;
  Function onChange;

  CustomSelectTask({required this.title, required this.onChange, Key? key})
      : super(key: key);

  @override
  State<CustomSelectTask> createState() => _CustomSelectTaskState();
}

class _CustomSelectTaskState extends State<CustomSelectTask> {
  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of<TaskProvider>(context);

    return taskProvider.task != null
        ? Container(
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
                value: taskProvider.selectedTask,
                onChanged: (Task? task) {
                  taskProvider.selectedTask = task;
                  widget.onChange();
                },
                items: taskProvider.task.map((task) {
                  return DropdownMenuItem(
                    child: Text(task.title),
                    value: task,
                  );
                }).toList(),
              ),
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
