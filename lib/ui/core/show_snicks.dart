import 'package:assault/ui/core/styles.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void displayErrorMessage({
  @required String error,
  @required dynamic context,
  @required scaffoldKey,
  bool popStack = true,
}) {
  //ExtendedNavigator.of(context).pop();
  popStack
      ? Navigator.of(context?.currentContext, rootNavigator: true).pop()
      : null;
  scaffoldKey.currentState.showSnackBar(
    SnackBar(
      backgroundColor: kBlackColor,
      content: Text(
        error,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      duration: const Duration(milliseconds: 3000),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

void displaySuccessMessage({
  @required String text,
  @required context,
  @required scaffoldKey,
  bool popStack = true,
}) {
  Navigator.of(context, rootNavigator: true).pop();
  scaffoldKey.currentState.showSnackBar(
    SnackBar(
      backgroundColor: Colors.green,
      content: Text(
        text,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      duration: const Duration(milliseconds: 3000),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
