import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:task_manager/src/design/colors.dart';
import 'package:task_manager/src/design/strings.dart';
import 'package:task_manager/src/pages/account.dart';
import 'package:task_manager/src/pages/action_task.dart';
import 'package:task_manager/src/pages/list_task_programmers.dart';
import 'package:task_manager/src/providers/auth.dart';
import 'package:task_manager/src/providers/navigator_index.dart';

class DashBoardPageProgrammer extends StatefulWidget {
  const DashBoardPageProgrammer({Key? key}) : super(key: key);

  @override
  _DashBoardPageProgrammerState createState() =>
      _DashBoardPageProgrammerState();
}

class _DashBoardPageProgrammerState extends State<DashBoardPageProgrammer> {
  final List<String> titles = [
    AppStrings.titleHome,
    AppStrings.titleActionTask,
    AppStrings.titleAccount,
  ];

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    NavigatorIndex navigatorIndex = Provider.of<NavigatorIndex>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(titles[navigatorIndex.selectedIndexHome]),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: AppColors.circleAvatarColor,
              child: Text(
                authProvider.user != null
                    ? authProvider.user!.name.substring(0, 2)
                    : '',
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: navigatorIndex.selectedIndexHome,
        onTap: (index) => _onItemTapped(index, navigatorIndex),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: AppStrings.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow),
            label: AppStrings.titleActionTask,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined,
            ),
            label: AppStrings.account,
          ),
        ],
      ),
      body: IndexedStack(
        index: navigatorIndex.selectedIndexHome,
        children: [
          ListTaskProgrammers(),
          const ActionTaskPage(),
          const AccountPage(),
        ],
      ),
    );
  }

  void _onItemTapped(int index, NavigatorIndex navigatorIndex) {
    navigatorIndex.selectedIndexHome = index;
  }
}
