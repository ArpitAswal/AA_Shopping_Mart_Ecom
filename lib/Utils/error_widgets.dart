
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ErrorWidgets{

  // Global key to access context when needed
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static showErrorSnackBar({required String msg, Color bgColor = Colors.deepPurpleAccent}) {
    final context = navigatorKey.currentContext;
      final bar = SnackBar(
        content: const Text('Hii this is GFG\'s SnackBar'),
        backgroundColor: bgColor,
        elevation: 10,
        behavior: SnackBarBehavior.fixed,
        margin: const EdgeInsets.all(5),
      );
      if(context != null) {
        ScaffoldMessenger.of(context).showSnackBar(bar);
      }
  }

  static void toastMessage({required String str, Color textColor = Colors.black, Color bgColor = Colors.white}) {
    Fluttertoast.showToast(
        msg: str,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: bgColor,
        textColor: textColor,
        fontSize: 16.0
    );
  }
}