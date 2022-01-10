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
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _dialogKey = new GlobalKey<State>();

  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final _formKey = new GlobalKey<FormState>();

  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  login() async {
    String email = _conEmail.text;
    String passwd = _conPassword.text;

    if (email.isEmpty) {
      alertDialog(context, "Please Enter  Email");
    } else if (passwd.isEmpty) {
      alertDialog(context, "Please Enter Password");
    } else {
      await dbHelper.getLoginUser(email, passwd).then((userData) async {
        if (userData != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("email", 'email');
          Dialogs.showLoadingDialog(context, key: _dialogKey);
          Timer(Duration(seconds: 2), () {
            Navigator.of(context).pop();
            setSP(userData).whenComplete(() {
              Navigator.pushReplacementNamed(context, AssaultPages.home);
            });
          });
        } else {
          Dialogs.showLoadingDialog(context, key: _dialogKey);
          Timer(Duration(seconds: 2), () {
            Navigator.of(context).pop();
            alertDialog(context, "Invalid loggin details");
          });
        }
      }).catchError((error) {
        print(error);
        alertDialog(context, "Error: Login Fail");
      });
    }
  }

  Future setSP(UserModel user) async {
    final SharedPreferences sp = await _pref;

    sp.setString("user_id", user.user_id);
    sp.setString("user_name", user.user_name);
    sp.setString("email", user.email);
    sp.setString("password", user.password);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
    );

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
                  height: 20,
                ),
                Text(
                  'Login account',
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
                        isPassword: true,
                      ),
                      SizedBox(
                        height: SizeConfig.minBlockVertical,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: RichText(
                          text: TextSpan(
                            text: "Forgot your password? ",
                            style: TextStyle(
                              color: kPrimaryTextColor,
                            ),
                            children: [
                              TextSpan(
                                text: "Reset it",
                                style: TextStyle(
                                  color: kPrimaryColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).pushReplacementNamed(
                                        AssaultPages.resetPasswordScreen);
                                    // ExtendedNavigator.of(context)
                                    //     .push(Routes.resetPasswordScreen);
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.minBlockVertical * 5.0,
                      ),
                      SolidButton(
                        text: 'Login',
                        onPressed: login,
                        color: kPrimaryColor,
                        textColor: Colors.white,
                      ),
                      SizedBox(
                        height: SizeConfig.minBlockVertical,
                      ),
                      SizedBox(
                        height: SizeConfig.minBlockVertical,
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
                      text: "Don\'t have an account? ",
                      style: TextStyle(
                        color: kPrimaryTextColor,
                      ),
                      children: [
                        TextSpan(
                          text: "Signup",
                          style: TextStyle(
                            color: kPrimaryColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context)
                                  .pushNamed(AssaultPages.registration);
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
