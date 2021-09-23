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
import 'package:task_manager/src/providers/task.dart';
import 'package:task_manager/src/widgets/custom_buttom.dart';
import 'package:task_manager/src/widgets/custom_input.dart';
import 'package:task_manager/src/widgets/custom_input_date.dart';
import 'package:task_manager/src/widgets/custom_select.dart';
import 'package:task_manager/src/widgets/custom_select_user.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({Key? key}) : super(key: key);

  @override
  _NewTaskPageState createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  List<User>? responsables = [];
  final List<String> types = [
    'Onat',
    'Inventario',
    'Alquiler',
    'Compra producto',
    'Transporte',
  ];

  final List<String> projects = [
    'Proyecto 1',
    'Proyecto 2',
    'Proyecto 3',
    'Proyecto 4',
  ];

  late TextEditingController title;
  late TextEditingController description;
  late String complianceDate;
  String? type;
  String? project;
  bool resetSelectStringValue = false;

  @override
  void initState() {
    super.initState();
    title = TextEditingController();
    description = TextEditingController();
    complianceDate = DateTime.now().toString();

    Future.delayed(Duration.zero, () {
      DataProvider dataProvider =
          Provider.of<DataProvider>(context, listen: false);
      setState(() => responsables = dataProvider.manager!);
    });
  }

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    TaskProvider taskProvider = Provider.of<TaskProvider>(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.pvl1,
            horizontal: AppDimensions.phl1,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                CustomInput(
                  textController: title,
                  placeholder: 'Title',
                ),
                CustomSelectUser(
                  users: responsables,
                  title: 'Select responsable',
                ),
                CustomSelect(
                    reset: resetSelectStringValue,
                    elements: types,
                    title: 'Select type task',
                    onChange: (value) {
                      setState(() {
                        resetSelectStringValue = false;
                        type = value;
                      });
                    }),
                CustomSelect(
                    reset: resetSelectStringValue,
                    elements: projects,
                    title: 'Select project',
                    onChange: (value) {
                      setState(() {
                        resetSelectStringValue = false;
                        project = value;
                      });
                    }),
                CustomInputDate(
                  onChange: (date) {
                    setState(() => complianceDate = date.toString());
                  },
                ),
                CustomInput(
                  textController: description,
                  placeholder: 'Description',
                  maxLines: 4,
                ),
                ButtonFill(
                  text: "SAVE",
                  color: AppColors.primaryColor,
                  textColor: Colors.white,
                  onPress: () => _saveTask(context, authProvider, taskProvider),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveTask(BuildContext context, AuthProvider authProvider,
      TaskProvider taskProvider) async {
    if (title.text.isNotEmpty &&
        description.text.isNotEmpty &&
        type != null &&
        project != null &&
        taskProvider.selectedResponsable != null) {
      CustomDialogs.showLoadingDialog(context: context);
      bool res = await TaskDB.insert(
        Task(
          author: authProvider.user!,
          complianceDate: complianceDate,
          description: description.text,
          project: project!,
          responsable: taskProvider.selectedResponsable!,
          status: "New",
          title: title.text,
          type: type!,
          users: [],
        ),
      );
      Navigator.pop(context);
      if (res) {
        CustomSnackBar.showSnakBar(
          context: context,
          msg: 'Task successfully registered!',
          bgcolor: Colors.green,
        );
        await taskProvider.getTaks();
      } else {
        CustomSnackBar.showSnakBar(
          context: context,
          msg: 'Unregistered task',
          bgcolor: Colors.red,
        );
      }
      resetData(taskProvider);
    } else {
      CustomDialogs.showAlertDialog(
        title: AppStrings.titleAlertNotData,
        msg: AppStrings.contentAlertNotData,
        context: context,
      );
    }
  }

  void resetData(TaskProvider taskProvider) {
    title.clear();
    description.clear();
    complianceDate = DateTime.now().toString();
    setState(() {
      type = null;
      project = null;
      taskProvider.selectedResponsable = null;
      resetSelectStringValue = true;
    });
  }
}
