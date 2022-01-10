import 'package:assault/providers/user_provider.dart';
import 'package:assault/ui/app/welcome/welcome_screen.dart';
import 'package:assault/ui/core/size_config.dart';
import 'package:assault/ui/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreenBody extends StatefulWidget {
  SplashScreenBody();

  @override
  _SplashScreenBodyState createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 4), () {
        Navigator.of(context).pushReplacementNamed(AssaultPages.welcome);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/uni.png',
                  scale: 2,
                ),
                SizedBox(
                  height: SizeConfig.minBlockVertical * 5,
                ),
                Text(
                  'mobile crime reporting system'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.minBlockVertical * 5,
                ),
                Text(
                  'by'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.minBlockVertical * 5,
                ),
                Text(
                  'Johnson Esther Teniola'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '18/52hl135'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
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
