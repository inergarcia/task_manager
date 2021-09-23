import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:task_manager/src/design/colors.dart';
import 'package:task_manager/src/helpers/date.dart';
import 'package:task_manager/src/providers/auth.dart';
import 'package:task_manager/src/providers/task.dart';

class ListTaskProgrammers extends StatelessWidget {
  ListTaskProgrammers({Key? key}) : super(key: key);

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of<TaskProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
        body: SmartRefresher(
      physics: const BouncingScrollPhysics(),
      controller: refreshController,
      enablePullDown: true,
      header: const WaterDropHeader(
        failed: Icon(
          Icons.error_outline,
          color: AppColors.primaryColor,
          size: 30,
        ),
        complete: Icon(
          Icons.check_outlined,
          size: 30,
          color: AppColors.primaryColor,
        ),
        waterDropColor: AppColors.primaryColor,
      ),
      onRefresh: () => taskProvider
          .getTaksByIdOfProgrammer(id: authProvider.user!.id)
          .then((value) {
        if (taskProvider.task.isNotEmpty) {
          refreshController.refreshCompleted();
        } else {
          refreshController.refreshFailed();
        }
      }),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: taskProvider.task.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(taskProvider.task[index].title),
            subtitle: Text(
              CustomDate.parseMDY(taskProvider.task[index].complianceDate),
            ),
            trailing: SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(taskProvider.task[index].status),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.grey,
                    size: 20,
                  )
                ],
              ),
            ),
            onTap: () {
              taskProvider.selectedTask = taskProvider.task[index];
              Navigator.of(context).pushNamed('taskDetails');
            },
          );
        },
      ),
    ));
  }
}
