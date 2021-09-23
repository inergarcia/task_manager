import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:task_manager/src/design/colors.dart';
import 'package:task_manager/src/providers/data.dart';
import 'package:task_manager/src/providers/navigator_index.dart';
import 'package:task_manager/src/providers/notifications.dart';
import 'package:task_manager/src/providers/task.dart';
import 'package:task_manager/src/routes/routes.dart';
import 'package:task_manager/src/design/strings.dart';
import 'package:task_manager/src/providers/auth.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DataProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NavigatorIndex(),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationsProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.titleApp,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.primaryColor,
          ),
          hintColor: Colors.black,
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: AppColors.background,
          fontFamily: "OpenSans",
        ),
        initialRoute: 'login',
        routes: appRoutes,
      ),
    );
  }
}
