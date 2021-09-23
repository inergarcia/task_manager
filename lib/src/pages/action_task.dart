import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:task_manager/src/db/task.dart';
import 'package:task_manager/src/models/task.dart';
import 'package:task_manager/src/design/colors.dart';
import 'package:task_manager/src/providers/auth.dart';
import 'package:task_manager/src/design/strings.dart';
import 'package:task_manager/src/providers/task.dart';
import 'package:task_manager/src/design/dimensions.dart';
import 'package:task_manager/src/widgets/custom_buttom.dart';
import 'package:task_manager/src/helpers/custom_dialogs.dart';
import 'package:task_manager/src/providers/notifications.dart';
import 'package:task_manager/src/helpers/custom_snack_bar.dart';
import 'package:task_manager/src/providers/navigator_index.dart';
import 'package:task_manager/src/widgets/custom_select_task.dart';

class ActionTaskPage extends StatefulWidget {
  const ActionTaskPage({Key? key}) : super(key: key);

  @override
  _ActionTaskPageState createState() => _ActionTaskPageState();
}

class _ActionTaskPageState extends State<ActionTaskPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      NotificationsProvider notificationsProvider =
          Provider.of<NotificationsProvider>(context, listen: false);
      TaskProvider taskProvider = Provider.of(context, listen: false);

      notificationsProvider.init();

      taskProvider.selectedTask = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of<TaskProvider>(context);
    NavigatorIndex navigatorIndex = Provider.of<NavigatorIndex>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    NotificationsProvider notificationsProvider =
        Provider.of<NotificationsProvider>(context, listen: false);

    return Scaffold(
      body: navigatorIndex.selectedIndexHome == 1
          ? Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.pvl1,
                horizontal: AppDimensions.phl1,
              ),
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  CustomSelectTask(
                    title: AppStrings.selectTask,
                    onChange: () {},
                  ),
                  if (taskProvider.selectedTask != null)
                    Text(
                      "Your task status is ${taskProvider.selectedTask!.status}",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 18,
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  ButtonFill(
                    color: AppColors.primaryColor,
                    text: AppStrings.startTask,
                    onPress: () => setStatus(
                      status: "In process",
                      taskProvider: taskProvider,
                      notificationsProvider: notificationsProvider,
                      authProvider: authProvider,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ButtonFill(
                    color: AppColors.primaryColor,
                    text: AppStrings.endTask,
                    onPress: () => setStatus(
                      status: "Close",
                      taskProvider: taskProvider,
                      notificationsProvider: notificationsProvider,
                      authProvider: authProvider,
                    ),
                  ),
                ],
              ),
            )
          : Container(),
    );
  }

  Future<void> setStatus({
    required String status,
    required TaskProvider taskProvider,
    required NotificationsProvider notificationsProvider,
    required AuthProvider authProvider,
  }) async {
    if (taskProvider.selectedTask != null) {
      if (taskProvider.selectedTask!.status == status) {
        CustomSnackBar.showSnakBar(
          context: context,
          msg: 'Your task has that status!',
          bgcolor: Colors.green,
        );
      } else {
        Task newTask = taskProvider.selectedTask!;
        newTask.status = status;
        bool res = await TaskDB.update(newTask);
        if (res == true) {
          taskProvider.selectedTask = null;
          await taskProvider.getTaksByIdOfProgrammer(id: authProvider.user!.id);
          await notificationsProvider.showNotification(
              title: "Status Change",
              msg: "Your task status has ben changed to $status");

          CustomSnackBar.showSnakBar(
            context: context,
            msg: 'Status changed successfully!',
            bgcolor: Colors.green,
          );
        } else {
          CustomSnackBar.showSnakBar(
            context: context,
            msg: 'Status not changed!',
            bgcolor: Colors.red,
          );
        }
      }
    } else {
      CustomDialogs.showAlertDialog(
        title: AppStrings.titleAlertNotData,
        msg: AppStrings.contentAlertNotData,
        context: context,
      );
    }
  }
}
