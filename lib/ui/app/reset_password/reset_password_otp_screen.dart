import 'dart:async';

import 'package:assault/providers/user_provider.dart';
import 'package:assault/ui/core/dialogs.dart';
import 'package:assault/ui/core/input_box.dart';
import 'package:assault/ui/core/show_snicks.dart';
import 'package:assault/ui/core/size_config.dart';
import 'package:assault/ui/core/solid_button.dart';
import 'package:assault/ui/core/styles.dart';
import 'package:assault/ui/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ResetPasswordOtpScreen extends StatefulWidget {
  ResetPasswordOtpScreen();

  @override
  _ResetPasswordOtpScreenState createState() => _ResetPasswordOtpScreenState();
}

class _ResetPasswordOtpScreenState extends State<ResetPasswordOtpScreen> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _otpController = TextEditingController();
  final _dialogKey = new GlobalKey<State>();
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.minBlockVertical * 3.0,
                ),
                Text(
                  'Enter otp',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.minBlockVertical * 5.0,
                ),
                Form(
                  key: _formState,
                  child: Column(
                    children: [
                      InputBox(
                        controller: _otpController,
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return "Otp cannot be empty";
                          }
                          return null;
                        },
                        borderSide: BorderSide(
                          color: kSecondaryBorder,
                        ),
                        labelText: 'Otp',
                        inputType: TextInputType.numberWithOptions(),
                        inputFormat: [FilteringTextInputFormatter.digitsOnly],
                        maxLength: 5,
                      ),
                      SizedBox(
                        height: SizeConfig.minBlockVertical * 5.0,
                      ),
                      SolidButton(
                        text: 'Verify',
                        onPressed: () async {
                          // if (_formState.currentState.validate()) {
                          //   Dialogs.showLoadingDialog(context, key: _dialogKey);
                        },
                        color: kPrimaryColor,
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
