import 'package:flutter/material.dart';

import 'package:task_manager/src/pages/login.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'login': (_) => const LoginPage(),
};
