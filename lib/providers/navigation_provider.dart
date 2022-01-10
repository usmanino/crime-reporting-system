import 'package:assault/models/analytic_model.dart';
import 'package:assault/providers/user_provider.dart';
import 'package:assault/services/network_services.dart';
import 'package:assault/ui/app/complaint/complaint_screen.dart';
import 'package:assault/ui/app/home/home_screen_body.dart';
import 'package:assault/ui/app/profile/profile_screen.dart';
import 'package:assault/ui/app/search/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationProvider with ChangeNotifier {
  int _currentIndex = 0;
  Map _analyticMapModel;

  final _pages = [
    HomeScreenBody(),
    ComplaintScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];

  int get curentIndex => _currentIndex;

  get pages => _pages;

  get analyticMapModel => _analyticMapModel;

  set curentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  getChart() async {
    // prefs = await _sharedPreferences;
    // String token = prefs.getString("access_token").toString();
    // final _analyticModel = await NetworkServices.getAnalytics(token: token);
    // if (_analyticModel != null && _analyticModel.data != null) {
    //   _analyticMapModel = Map.fromIterable(_analyticModel.data,
    //       key: (key) => key.state,
    //       value: (value) => double.parse(value.count.toString()));
    notifyListeners();
  }
}
