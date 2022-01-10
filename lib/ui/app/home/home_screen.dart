import 'package:assault/providers/navigation_provider.dart';
import 'package:assault/providers/user_provider.dart';
import 'package:assault/ui/core/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final bottomProvider = Provider.of<NavigationProvider>(context);

    return AnnotatedRegion(
      value: SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [
          SystemUiOverlay.top,
          SystemUiOverlay.bottom,
        ],
      ),
      child: Scaffold(
        body: SafeArea(
          child: bottomProvider.pages[bottomProvider.curentIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.phone_in_talk), label: 'Complaint'),
            //if (!userProvider.isAnonymousLogin)
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
          ],
          onTap: (index) {
            bottomProvider.curentIndex = index;
          },
          currentIndex: bottomProvider.curentIndex,
          unselectedItemColor: Colors.grey,
          selectedItemColor: kPrimaryColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 14,
          unselectedFontSize: 14,
        ),
      ),
    );
  }
}
