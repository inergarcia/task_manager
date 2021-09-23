import 'package:flutter/material.dart';

import 'package:task_manager/src/db/task.dart';
import 'package:task_manager/src/models/task.dart';
import 'package:task_manager/src/models/user.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _task = [];
  Task? _selectedTask;
  User? _selectedResponsable;
  String? _selectedTypeTask;
  String? _selectedProject;

  List<Task> get task => _task;
  Task? get selectedTask => _selectedTask;

  User? get selectedResponsable => _selectedResponsable;
  String? get selectedTypeTask => _selectedTypeTask;
  String? get selectedProject => _selectedProject;

  set selectedResponsable(User? responsable) {
    _selectedResponsable = responsable;
    notifyListeners();
  }

  set selectedTypeTask(String? typeT) {
    _selectedTypeTask = typeT;
    notifyListeners();
  }

  set selectedProject(String? project) {
    _selectedProject = project;
    notifyListeners();
  }

  set selectedTask(Task? task) {
    _selectedTask = task;
    notifyListeners();
  }

  Future<void> getTaks() async {
    _task = await TaskDB.getTasks();
    notifyListeners();
  }

  Future<void> getTaksByIdOfManager({required int id}) async {
    List<Task> allTask = await TaskDB.getTasks();
    _task = allTask.where((task) => task.responsable.id == id).toList();

    notifyListeners();
  }

  Future<void> getTaksByIdOfProgrammer({required int id}) async {
    List<Task> allTask = await TaskDB.getTasks();
    _task = allTask
        .where((task) => isProgrammer(users: task.users, id: id))
        .toList();

    notifyListeners();
  }

  bool isProgrammer({required List<User> users, required int id}) {
    for (User user in users) {
      if (user.id == id) {
        return true;
      }
    }
    return false;
  }
}
