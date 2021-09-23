import 'package:flutter/material.dart';

class NavigatorIndex with ChangeNotifier {
  int _selectedIndexHome = 0;

  int get selectedIndexHome => _selectedIndexHome;

  set selectedIndexHome(int index) {
    _selectedIndexHome = index;
    notifyListeners();
  }
}
