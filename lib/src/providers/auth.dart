import 'package:flutter/material.dart';

import 'package:task_manager/src/models/user.dart';
import 'package:task_manager/src/providers/data.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;

  User? get user => _user;

  bool get isLoading => _isLoading;

  Future<bool> login(
      {required String username,
      required String pass,
      required DataProvider dataProvider}) async {
    //In this method the authentication functionality will be implemented

    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    if (username == "admin" && pass == "123") {
      _user = User(
        id: 100,
        role: "principal_manager",
        username: "admin",
        name: "Juan Perez",
      );
      _isLoading = false;
      notifyListeners();
      return true;
    }

    User? usr = findUser(username, dataProvider);
    if (usr != null && pass == "123") {
      _user = usr;
      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> logout() async {
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
    return true;
  }

  User? findUser(String username, DataProvider dataProvider) {
    for (User usr in dataProvider.manager!) {
      if (usr.username == username) {
        return usr;
      }
    }

    for (User usr in dataProvider.users!) {
      if (usr.username == username) {
        return usr;
      }
    }

    return null;
  }
}
