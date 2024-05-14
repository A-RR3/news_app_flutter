import 'package:flutter/material.dart';

class NavigationServices {
  static back(BuildContext context) => Navigator.pop(context);

  static navigateTo(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}
