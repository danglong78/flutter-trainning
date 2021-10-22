import 'package:demo_retrofit_moor/custom_theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider();
  bool isPink = true;
  ThemeData get theme => isPink ? CustomTheme.pinkTheme : CustomTheme.cyanTheme;

  void changeTheme() {
    isPink = !isPink;
    notifyListeners();
  }
}
