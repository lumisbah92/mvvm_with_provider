import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvvm_with_provider/res/color.dart';

class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(msg: message, backgroundColor: AppColors.greenColor, fontSize: 20);
  }

  static void flushBarErrorMessage(BuildContext context, String message) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        message: message,
        title: "Error",
        messageColor: AppColors.blackColor,
        backgroundColor: AppColors.redColor,
        duration: Duration(seconds: 3),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.all(15),
        borderRadius: BorderRadius.circular(20),
        forwardAnimationCurve: Curves.decelerate,
        flushbarPosition: FlushbarPosition.BOTTOM,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: Icon(Icons.error, size: 20, color: AppColors.whiteColor),
      )..show(context),
    );
  }

  static snackBar(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: AppColors.redColor,
    ));
  }
}
