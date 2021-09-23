import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:task_manager/src/design/colors.dart';
import 'package:task_manager/src/design/strings.dart';
import 'package:task_manager/src/helpers/custom_dialogs.dart';
import 'package:task_manager/src/providers/auth.dart';
import 'package:task_manager/src/providers/navigator_index.dart';
import 'package:task_manager/src/widgets/setting_item.dart';
import 'package:task_manager/src/widgets/setting_title.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({
    Key? key,
  }) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final NavigatorIndex navigatorIndex = Provider.of<NavigatorIndex>(context);

    return Scaffold(
      body: authProvider.user != null
          ? ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                SettingTitle(
                  text: AppStrings.user,
                  items: [
                    ListTile(
                      minLeadingWidth: 0,
                      leading: const Icon(
                        Icons.person_outline,
                        color: AppColors.primaryColor,
                        size: 25,
                      ),
                      tileColor: Colors.white,
                      title: Text(authProvider.user!.name),
                    ),
                    ListTile(
                      minLeadingWidth: 0,
                      leading: const Icon(
                        Icons.email_outlined,
                        color: AppColors.primaryColor,
                        size: 25,
                      ),
                      tileColor: Colors.white,
                      title: Text(authProvider.user!.username),
                    ),
                    SettingItem(
                      text: AppStrings.logout,
                      icon: Icons.arrow_forward_ios_outlined,
                      onPress: () =>
                          _logout(context, authProvider, navigatorIndex),
                    ),
                  ],
                ),
              ],
            )
          : Container(),
    );
  }

  void _logout(BuildContext context, AuthProvider authProvider,
      NavigatorIndex navigatorIndex) {
    CustomDialogs.showAlertDialogWihtCancel(
      title: AppStrings.logout,
      msg: AppStrings.closeSectionAnsw,
      context: context,
      onPress: () async {
        Navigator.pop(context);
        CustomDialogs.showLoadingDialog(context: context);
        await authProvider.logout();
        Navigator.pop(context);
        Navigator.of(context).pushReplacementNamed('login');
        navigatorIndex.selectedIndexHome = 0;
      },
    );
  }
}
