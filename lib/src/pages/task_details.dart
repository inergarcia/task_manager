import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:task_manager/src/design/colors.dart';
import 'package:task_manager/src/design/strings.dart';
import 'package:task_manager/src/helpers/date.dart';
import 'package:task_manager/src/providers/task.dart';
import 'package:task_manager/src/widgets/setting_title.dart';

class TaskDetailsPage extends StatelessWidget {
  const TaskDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(AppStrings.taskDetails),
        leading: IconButton(
          onPressed: () async {
            Navigator.pop(context);
            await Future.delayed(const Duration(microseconds: 1000));
            taskProvider.selectedTask = null;
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SettingTitle(
            text: AppStrings.title,
            items: [
              ListTile(
                minLeadingWidth: 0,
                tileColor: Colors.white,
                title: Text(taskProvider.selectedTask?.title ?? ''),
              ),
            ],
          ),
          SettingTitle(
            text: AppStrings.author,
            items: [
              ListTile(
                minLeadingWidth: 0,
                tileColor: Colors.white,
                title: Text(taskProvider.selectedTask!.author.name),
              ),
            ],
          ),
          SettingTitle(
            text: AppStrings.date,
            items: [
              ListTile(
                minLeadingWidth: 0,
                tileColor: Colors.white,
                title: Text(CustomDate.parseMDY(
                    taskProvider.selectedTask!.complianceDate)),
              ),
            ],
          ),
          SettingTitle(
            text: AppStrings.description,
            items: [
              ListTile(
                minLeadingWidth: 0,
                tileColor: Colors.white,
                title: Text(
                  taskProvider.selectedTask!.description,
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
          SettingTitle(
            text: AppStrings.type,
            items: [
              ListTile(
                minLeadingWidth: 0,
                tileColor: Colors.white,
                title: Text(
                  taskProvider.selectedTask!.type,
                ),
              ),
            ],
          ),
          SettingTitle(
            text: AppStrings.project,
            items: [
              ListTile(
                minLeadingWidth: 0,
                tileColor: Colors.white,
                title: Text(
                  taskProvider.selectedTask!.project,
                ),
              ),
            ],
          ),
          SettingTitle(
            text: AppStrings.status,
            items: [
              ListTile(
                minLeadingWidth: 0,
                tileColor: Colors.white,
                title: Text(
                  taskProvider.selectedTask!.status,
                ),
              ),
            ],
          ),
          SettingTitle(
            text: AppStrings.responsable,
            items: [
              ListTile(
                minLeadingWidth: 0,
                tileColor: Colors.white,
                title: Text(
                  taskProvider.selectedTask!.responsable.name,
                ),
              ),
            ],
          ),
          SettingTitle(
            text: AppStrings.programmers,
            items: [
              ListTile(
                minLeadingWidth: 0,
                tileColor: Colors.white,
                title: taskProvider.selectedTask!.users.isNotEmpty
                    ? Wrap(
                        children: [
                          ...List.generate(
                            taskProvider.selectedTask!.users.length,
                            (index) => Container(
                              margin: const EdgeInsets.all(3),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                  taskProvider.selectedTask!.users[index].name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        ],
                      )
                    : const Text(AppStrings.noYetAssig),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
