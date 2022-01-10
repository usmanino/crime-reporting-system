import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

alertDialog(BuildContext context, String msg) {
  Toast.show(
    msg,
    context,
    duration: 2,
    gravity: Toast.BOTTOM,
    backgroundColor: Colors.black,
  );
}

validateEmail(String email) {
  final emailReg = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  return emailReg.hasMatch(email);
}
