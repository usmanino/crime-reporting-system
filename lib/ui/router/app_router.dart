import 'package:assault/ui/app/change_password/change_password_screen.dart';
import 'package:assault/ui/app/complaint/add_complaint_screen.dart';
import 'package:assault/ui/app/complaint/add_complaint_screen_two.dart';
import 'package:assault/ui/app/complaint_details/complaint_details_screen.dart';
import 'package:assault/ui/app/edit_profile/edit_profile_screen.dart';
import 'package:assault/ui/app/home/home_screen.dart';
import 'package:assault/ui/app/list_complaint/list_complaint_screen.dart';
import 'package:assault/ui/app/login/login_screen.dart';
import 'package:assault/ui/app/register/register_otp_screen.dart';
import 'package:assault/ui/app/register/register_screen.dart';
import 'package:assault/ui/app/reset_password/reset_password_otp_screen.dart';
import 'package:assault/ui/app/reset_password/reset_password_screen.dart';
import 'package:assault/ui/app/search/search_result_screen.dart';
import 'package:assault/ui/app/splash/splash_screen.dart';
import 'package:assault/ui/app/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:assault/models/complaint_model.dart';

class AssaultPages {
  /// The first page when the app loads
  static const String splash = '/';

  static const String welcome = '/welcome';

  static const String started = '/started';

  static const String login = '/login';

  static const String registration = '/registration';

  static const String complaindetails = '/complaindetails';

  static const String searchresult = '/searchresult';

  static const String home = '/home';

  static const String resetPasswordOtpScreen = '/resetPasswordOtpScreen';

  static const String resetOtpScreen = '/resetOtpScreen';

  static const String editProfileScreen = '/editProfileScreen';

  static const String changePasswordScreen = '/changePasswordScreen';

  static const String resetPasswordScreen = '/resetPasswordScreen';

  static const String addcomplaintwo = '/addcomplaintwo';

  static const String addcomplaint = '/addcomplaint';

  static const String listcomplaint = '/listcomplaint';
}

///The main app routes logic using router generator
class AppRouter {
  ///list of all the app routes
  static Route route(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case AssaultPages.splash:
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return SplashScreen();
          },
        );

      case AssaultPages.welcome:
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return WelcomeScreen();
          },
        );

      case AssaultPages.registration:
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return RegisterScreen();
          },
        );

      case AssaultPages.login:
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return LoginScreen();
          },
        );

      case AssaultPages.complaindetails:
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return ComplaintDetailsScreen(complaintId: args);
          },
        );

      case AssaultPages.searchresult:
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return SearchResultScreen(searchQuery: args);
          },
        );

      case AssaultPages.home:
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return HomeScreen();
          },
        );

      case AssaultPages.resetPasswordOtpScreen:
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return ResetPasswordOtpScreen();
          },
        );

      case AssaultPages.resetOtpScreen:
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return RegisterOtpScreen();
          },
        );

      case AssaultPages.editProfileScreen:
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return EditProfileScreen();
          },
        );

      case AssaultPages.changePasswordScreen:
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return ChangePasswordScreen();
          },
        );

      case AssaultPages.resetPasswordScreen:
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return ResetPasswordScreen();
          },
        );

      case AssaultPages.addcomplaintwo:
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return AddComplaintScreenTwo(
              complaintModel: args,
            );
          },
        );

      case AssaultPages.addcomplaint:
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return AddComplaintScreen();
          },
        );

      case AssaultPages.listcomplaint:
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return ListComplaintScreen();
          },
        );

      // case ExquisitePages.splash:
      //   return MaterialPageRoute<Widget>(
      //     builder: (context) {
      //       return const SplashPage();
      //     },
      //   );

      // case ExquisitePages.started:
      //   return MaterialPageRoute<Widget>(
      //     builder: (context) {
      //       return const GetStartedPage();
      //     },
      //   );

      // case ExquisitePages.bottomnav:
      //   return MaterialPageRoute<Widget>(
      //     builder: (context) {
      //       return const BottomNavBar();
      //     },
      //   );

      // case ExquisitePages.login:
      //   return MaterialPageRoute<Widget>(
      //     builder: (context) {
      //       return const LoginPage();
      //     },
      //   );

      // case ExquisitePages.registration:
      //   return MaterialPageRoute<Widget>(
      //     builder: (context) {
      //       return const RegistrationPage();
      //     },
      //   );

      default:
        return MaterialPageRoute<Widget>(
          builder: (context) {
            return const Text('Error');
          },
        );
    }
  }
}
