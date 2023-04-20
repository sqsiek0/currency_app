import 'package:flutter/material.dart';

class ThemeSwitch extends ChangeNotifier {
  bool valueOfSwitch = false;


  void changeTheme(bool value) {
    valueOfSwitch = value;
    notifyListeners();
  }
}
