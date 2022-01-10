import 'dart:async';

import 'package:assault/helpers/DbHelper.dart';
import 'package:assault/models/user_model.dart';
import 'package:assault/providers/user_provider.dart';
import 'package:assault/ui/core/alert.dart';
import 'package:assault/ui/core/constants.dart';
import 'package:assault/ui/core/dialogs.dart';
import 'package:assault/ui/core/input_box.dart';
import 'package:assault/ui/core/show_snicks.dart';
import 'package:assault/ui/core/size_config.dart';
import 'package:assault/ui/core/solid_button.dart';
import 'package:assault/ui/core/styles.dart';
import 'package:assault/ui/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen();

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isVisiblePassword = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _conUserId = TextEditingController();
  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  final _conCPassword = TextEditingController();
  final _dialogKey = GlobalKey<State>();

  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  signUp() async {
    String uid = _conUserId.text;
    String uname = _conUserName.text;
    String email = _conEmail.text;
    String passwd = _conPassword.text;
    String cpasswd = _conCPassword.text;

    if (_formKey.currentState.validate()) {
      if (passwd != cpasswd) {
        Dialogs.showLoadingDialog(context, key: _dialogKey);
        alertDialog(context, 'Password Mismatch');
      } else {
        _formKey.currentState.save();

        UserModel uModel = UserModel(uid, uname, email, passwd);
        await dbHelper.saveData(uModel).then((userData) {
          Dialogs.showLoadingDialog(context, key: _dialogKey);

          Timer(Duration(seconds: 2), () {
            Navigator.of(context).pop();
            alertDialog(context, "Successfully Saved");
            Navigator.pushNamed(context, AssaultPages.login);
          });
        }).catchError((error) {
          print(error);
          Dialogs.showLoadingDialog(context, key: _dialogKey);

          Timer(Duration(seconds: 2), () {
            Navigator.of(context).pop();
            alertDialog(context, "Opps an error occur");
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
    );

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
                  'Register an account',
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
                  key: _formKey,
                  child: Column(
                    children: [
                      InputBox(
                        controller: _conUserId,
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return "nin";
                          }
                          return null;
                        },
                        borderSide: BorderSide(
                          color: kSecondaryBorder,
                        ),
                        labelText: 'NIN',
                        inputType: TextInputType.text,
                      ),
                      SizedBox(
                        height: SizeConfig.minBlockVertical * 5.0,
                      ),
                      InputBox(
                        controller: _conUserName,
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return "Username cannot be empty";
                          }
                          return null;
                        },
                        borderSide: BorderSide(
                          color: kSecondaryBorder,
                        ),
                        labelText: 'Username',
                        inputType: TextInputType.text,
                      ),
                      SizedBox(
                        height: SizeConfig.minBlockVertical * 5.0,
                      ),
                      InputBox(
                        controller: _conEmail,
                        validator: (value) {
                          Pattern pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp myReg = new RegExp(pattern);
                          if (value.trim().isEmpty)
                            return 'Email cannot be empty';
                          if (value.trim().length < 4)
                            return 'Invalid email supplied';
                          if (!myReg.hasMatch(value.trim()))
                            return 'Invalid email supplied';
                          return null;
                        },
                        borderSide: BorderSide(
                          color: kSecondaryBorder,
                        ),
                        labelText: 'Email Address',
                        inputType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: SizeConfig.minBlockVertical * 5.0,
                      ),
                      InputBox(
                        controller: _conPassword,
                        icon: isVisiblePassword
                            ? Icons.remove_red_eye_sharp
                            : Icons.remove_red_eye,
                        onIconClick: () {
                          setState(() {
                            isVisiblePassword = !isVisiblePassword;
                          });
                        },
                        validator: (value) {
                          if (value.trim().isEmpty)
                            return 'Password cannot be empty';
                          if (value.trim().length < 8)
                            return 'Password cannot be less than 8 characters';
                          return null;
                        },
                        borderSide: BorderSide(
                          color: kSecondaryBorder,
                        ),
                        labelText: 'Password',
                        isPassword: isVisiblePassword,
                      ),
                      SizedBox(
                        height: SizeConfig.minBlockVertical * 5.0,
                      ),
                      InputBox(
                        controller: _conCPassword,
                        icon: isVisiblePassword
                            ? Icons.remove_red_eye_sharp
                            : Icons.remove_red_eye,
                        onIconClick: () {
                          setState(() {
                            isVisiblePassword = !isVisiblePassword;
                          });
                        },
                        validator: (value) {
                          if (value.trim().isEmpty)
                            return 'Confirm Password cannot be empty';
                          if (value.trim().length < 8)
                            return 'Confirm Password cannot be less than 8 characters';
                          return null;
                        },
                        borderSide: BorderSide(
                          color: kSecondaryBorder,
                        ),
                        labelText: 'Confirm Password',
                        isPassword: isVisiblePassword,
                      ),
                      SizedBox(
                        height: SizeConfig.minBlockVertical * 5.0,
                      ),
                      SolidButton(
                        text: 'Register',
                        onPressed: signUp,
                        color: kPrimaryColor,
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.minBlockVertical * 5.0,
                ),
                Align(
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                        color: kPrimaryTextColor,
                      ),
                      children: [
                        TextSpan(
                          text: "Sign in",
                          style: TextStyle(
                            color: kPrimaryColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context)
                                  .pushNamed(AssaultPages.login);
                            },
                        ),
                      ],
                    ),
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
