import 'package:flutter/material.dart';

import 'package:task_manager/src/pages/dashboard_manager1.dart';
import 'package:task_manager/src/pages/dashboard_manager2.dart';
import 'package:task_manager/src/pages/dashboard_programmer.dart';
import 'package:task_manager/src/pages/login.dart';
import 'package:task_manager/src/pages/task_details.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'login': (_) => const LoginPage(),
  'dashboardManager1': (_) => const DashBoardPageManager1(),
  'dashboardManager2': (_) => const DashBoardPageManager2(),
  'dashboardProgrammer': (_) => const DashBoardPageProgrammer(),
  'taskDetails': (_) => const TaskDetailsPage(),
};
