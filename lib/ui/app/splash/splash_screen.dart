import 'package:assault/helpers/DbHelper.dart';
import 'package:assault/providers/user_provider.dart';
import 'package:assault/services/my_share.dart';
import 'package:assault/ui/app/home/home_screen.dart';
import 'package:assault/ui/app/splash/splash_screen_body.dart';
import 'package:assault/ui/app/welcome/welcome_screen.dart';
import 'package:assault/ui/core/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen();

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  DbHelper dbHelper;

  @override
  void initState() {
    super.initState();
    getUserData();

    dbHelper = DbHelper();
  }

  bool isLoggedIn = false;
  var email;
  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      print(email);
    });
  }

  bool hasToken = true;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    SizeConfig().init(context);

    if (email != null) {
      return HomeScreen();
    } else {
      return SplashScreenBody();
    }
  }
}
