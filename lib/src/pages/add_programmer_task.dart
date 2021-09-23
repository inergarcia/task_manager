import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:task_manager/src/db/task.dart';
import 'package:task_manager/src/design/colors.dart';
import 'package:task_manager/src/design/dimensions.dart';
import 'package:task_manager/src/design/strings.dart';
import 'package:task_manager/src/helpers/custom_dialogs.dart';
import 'package:task_manager/src/helpers/custom_snack_bar.dart';
import 'package:task_manager/src/models/task.dart';
import 'package:task_manager/src/models/user.dart';
import 'package:task_manager/src/providers/auth.dart';
import 'package:task_manager/src/providers/data.dart';
import 'package:task_manager/src/providers/navigator_index.dart';
import 'package:task_manager/src/providers/notifications.dart';
import 'package:task_manager/src/providers/task.dart';
import 'package:task_manager/src/widgets/custom_select_task.dart';

class AddProgrammerTaskPage extends StatefulWidget {
  const AddProgrammerTaskPage({Key? key}) : super(key: key);

  @override
  _AddProgrammerTaskPageState createState() => _AddProgrammerTaskPageState();
}

class _AddProgrammerTaskPageState extends State<AddProgrammerTaskPage> {
  List<bool> isCheck = [];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      NotificationsProvider notificationsProvider =
          Provider.of<NotificationsProvider>(context, listen: false);
      DataProvider dataProvider =
          Provider.of<DataProvider>(context, listen: false);
      TaskProvider taskProvider = Provider.of(context, listen: false);

      notificationsProvider.init();

      taskProvider.selectedTask = null;

      setCheck(dataProvider.users!.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of<TaskProvider>(context);
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    NavigatorIndex navigatorIndex = Provider.of<NavigatorIndex>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    NotificationsProvider notificationsProvider =
        Provider.of<NotificationsProvider>(context, listen: false);

    return Scaffold(
      floatingActionButton: isAddUser(taskProvider)
          ? FloatingActionButton(
              backgroundColor: AppColors.primaryColor,
              onPressed: () => addUsers(taskProvider, dataProvider,
                  notificationsProvider, authProvider),
              child: const Icon(Icons.add),
            )
          : null,
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
                    title: 'Select a Task',
                    onChange: () {
                      setCheckByTask(taskProvider, dataProvider);
                    },
                  ),
                  ...List.generate(
                    dataProvider.users!.length,
                    (index) => ListTile(
                      title: Text(dataProvider.users![index].name),
                      trailing: Checkbox(
                        activeColor: AppColors.primaryColor,
                        onChanged: (value) {
                          setState(() => isCheck[index] = value!);
                        },
                        value: isCheck[index],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container(),
    );
  }

  Future<void> addUsers(
      TaskProvider taskProvider,
      DataProvider dataProvider,
      NotificationsProvider notificationsProvider,
      AuthProvider authProvider) async {
    if (taskProvider.selectedTask != null) {
      Task task = taskProvider.selectedTask!;
      if (task.state == 'New') {
        task.state = 'Open';
      }
      task.users = [];
      for (int i = 0; i < isCheck.length; i++) {
        if (isCheck[i] == true) {
          task.users.add(dataProvider.users![i]);
        }
      }

      bool res = await TaskDB.update(task);
      if (res == true) {
        taskProvider.selectedTask = null;
        await taskProvider.getTaksByIdOfManager(id: authProvider.user!.id);
        await notificationsProvider.showNotification(
            title: "Assigned Task",
            msg: "The task has been notified to the established users.");

        CustomSnackBar.showSnakBar(
          context: context,
          msg: 'Users successfully added!',
          bgcolor: Colors.green,
        );
      } else {
        CustomSnackBar.showSnakBar(
          context: context,
          msg: 'Users not added!',
          bgcolor: Colors.red,
        );
      }
      setCheck(dataProvider.users!.length);
      taskProvider.selectedTask = null;
    } else {
      CustomDialogs.showAlertDialog(
        title: AppStrings.titleAlertNotData,
        msg: AppStrings.contentAlertNotData,
        context: context,
      );
    }
  }

  void setCheck(int size) {
    setState(() {
      isCheck = List.generate(size, (index) => false);
    });
  }

  void setCheckByTask(TaskProvider taskProvider, DataProvider dataProvider) {
    if (taskProvider.selectedTask!.users.isEmpty) {
      setCheck(dataProvider.users!.length);
    } else {
      setCheck(dataProvider.users!.length);
      for (User user in taskProvider.selectedTask!.users) {
        int index = dataProvider.users!.indexWhere((usr) => usr.id == user.id);
        isCheck[index] = true;
      }
    }
  }

  bool isAddUser(TaskProvider taskProvider) {
    if (taskProvider.selectedTask == null) {
      return false;
    }

    for (bool check in isCheck) {
      if (check) {
        return true;
      }
    }

    return false;
  }
}
