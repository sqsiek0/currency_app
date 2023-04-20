import 'package:currency_app/main_view/main_file.dart';
import 'package:flutter/material.dart';
import 'colors/colors.dart';
import 'package:provider/provider.dart';

void main() {
  final switchTheme = ThemeSwitch();
  runApp(
    ChangeNotifierProvider.value(value: switchTheme, child: const MainViewPage())
    // MainViewPage()
    );
}

