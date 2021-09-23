import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:task_manager/src/design/colors.dart';
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
        title: const Text('Task Details'),
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
            text: 'TITLE',
            items: [
              ListTile(
                minLeadingWidth: 0,
                tileColor: Colors.white,
                title: Text(taskProvider.selectedTask?.title ?? ''),
              ),
            ],
          ),
          SettingTitle(
            text: 'AUTHOR',
            items: [
              ListTile(
                minLeadingWidth: 0,
                tileColor: Colors.white,
                title: Text(taskProvider.selectedTask!.author.name),
              ),
            ],
          ),
          SettingTitle(
            text: 'DATE',
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
            text: 'DESCRIPTION',
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
            text: 'TYPE',
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
            text: 'PROJECT',
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
            text: 'STATUS',
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
            text: 'RESPONSABLE',
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
            text: 'PROGRAMMERS',
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
                    : const Text('Not yet assigned'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
