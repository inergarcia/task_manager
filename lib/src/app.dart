import 'package:flutter/material.dart';

import 'package:task_manager/src/design/colors.dart';
import 'package:task_manager/src/design/routes.dart';
import 'package:task_manager/src/design/strings.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
