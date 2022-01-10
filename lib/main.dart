import 'package:assault/main_screen.dart';
import 'package:assault/providers/complaint_provider.dart';
import 'package:assault/providers/intro_provider.dart';
import 'package:assault/providers/navigation_provider.dart';
import 'package:assault/providers/profile_provider.dart';
import 'package:assault/providers/search_provider.dart';
import 'package:assault/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: IntroProvider.initialize()),
          ChangeNotifierProvider(create: (context) => UserProvider()),
          ChangeNotifierProvider(create: (_) => NavigationProvider()),
          ChangeNotifierProvider.value(value: ComplaintProvider.initialize()),
          ChangeNotifierProvider.value(value: SearchProvider.initialize()),
          ChangeNotifierProvider.value(value: ProfileProvider.initialize()),
        ],
        child: MainScreen(),
      ),
    );
  });
}
