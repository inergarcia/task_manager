import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:task_manager/src/design/colors.dart';
import 'package:task_manager/src/design/dimensions.dart';
import 'package:task_manager/src/design/strings.dart';
import 'package:task_manager/src/helpers/custom_dialogs.dart';
import 'package:task_manager/src/providers/auth.dart';
import 'package:task_manager/src/providers/data.dart';
import 'package:task_manager/src/widgets/custom_buttom.dart';
import 'package:task_manager/src/widgets/custom_input.dart';
import 'package:task_manager/src/widgets/custom_input_pass.dart';
import 'package:task_manager/src/widgets/header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController username;
  late TextEditingController pass;

  @override
  void initState() {
    super.initState();

    username = TextEditingController();
    pass = TextEditingController();

    Future.delayed(Duration.zero, () async {
      DataProvider dataProvider = Provider.of(context, listen: false);
      await dataProvider.initData();
    });
  }

  @override
  void dispose() {
    username.dispose();
    pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    DataProvider dataProvider = Provider.of<DataProvider>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: Stack(
          children: <Widget>[
            const CustomHeader(
              title: AppStrings.titleLogin,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.pvl1,
                horizontal: AppDimensions.phl1,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomInput(
                    placeholder: AppStrings.userPlaceholder,
                    keywordType: TextInputType.emailAddress,
                    textController: username,
                  ),
                  CustomInputPass(
                    placeholder: AppStrings.passPlaceholder,
                    textController: pass,
                  ),
                  ButtonFill(
                    text: AppStrings.titleLogin,
                    color: AppColors.primaryColor,
                    inProcces: authProvider.isLoading,
                    textColor: Colors.white,
                    onPress: () => _login(authProvider, context, dataProvider),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _login(AuthProvider authProvider, BuildContext context,
      DataProvider dataProvider) async {
    if (username.text.isNotEmpty && pass.text.isNotEmpty) {
      bool res = await authProvider.login(
          username: username.text, pass: pass.text, dataProvider: dataProvider);

      if (res) {
        if (authProvider.user!.role == "principal_manager") {
          Navigator.of(context).pushReplacementNamed('dashboardManager1');
          username.clear();
          pass.clear();
        } else if (authProvider.user!.role == "secundary_manager") {
          Navigator.of(context).pushReplacementNamed('dashboardManager2');
          username.clear();
          pass.clear();
        } else {
          Navigator.of(context).pushReplacementNamed("dashboardProgrammer");
          username.clear();
          pass.clear();
        }
      } else {
        CustomDialogs.showAlertDialog(
          title: AppStrings.titleAlertNotLogin,
          msg: AppStrings.contentAlertNotLogin,
          context: context,
        );
        username.clear();
        pass.clear();
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
