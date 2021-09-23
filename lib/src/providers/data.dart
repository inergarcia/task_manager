import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:task_manager/src/models/user.dart';

class DataProvider with ChangeNotifier {
  List<User>? _users;
  List<User>? _managers;

  List<User>? get users => _users;
  List<User>? get manager => _managers;

  Future<void> initData() async {
    final String response = await rootBundle.loadString('assets/user.json');
    final data = await json.decode(response);

    List<dynamic> userList = data['users'];
    List<dynamic> managerList = data['managers'];

    _users = List.generate(
        userList.length, (index) => User.fromJson(userList[index]));
    _managers = List.generate(
        managerList.length, (index) => User.fromJson(managerList[index]));
  }
}
