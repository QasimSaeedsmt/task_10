import 'package:flutter/material.dart';

import '../constants/constants_resources.dart';

extension BuildContextX on BuildContext {
  void navigateTo(Widget page) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => page));
  }

  void pushAndRemoveAll(Widget page) {
    Navigator.pushAndRemoveUntil(
        this,
        MaterialPageRoute(builder: (context) => page),
        (Route<dynamic> route) => false);
  }

  void showSnackbar(String message,
      {Duration? duration, SnackBarAction? action, Color? backgroundColor}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ??
            const Duration(seconds: ConstantsResources.SNACKBAR_DELAY),
        action: action,
        backgroundColor: backgroundColor ?? Colors.redAccent,
      ),
    );
  }
}
