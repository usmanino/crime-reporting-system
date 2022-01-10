import 'dart:async';

import 'package:assault/helpers/DbHelper.dart';
import 'package:assault/models/complaint_model.dart';
import 'package:assault/models/response_message_model.dart';
import 'package:assault/providers/complaint_provider.dart';
import 'package:assault/providers/navigation_provider.dart';
import 'package:assault/providers/user_provider.dart';
import 'package:assault/ui/core/constants.dart';
import 'package:assault/ui/core/dialogs.dart';
import 'package:assault/ui/core/size_config.dart';
import 'package:assault/ui/core/styles.dart';
import 'package:assault/ui/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenBody extends StatefulWidget {
  HomeScreenBody({Key key}) : super(key: key);

  @override
  _HomeScreenBodyState createState() => _HomeScreenBodyState();
}

enum LegendShape { Circle, Rectangle }

class _HomeScreenBodyState extends State<HomeScreenBody> {
  String numOfComplaint;
  Map<String, double> dataMap = {
    "Tanke": 5,
    "Eleko": 3,
    "Fate": 2,
    "Maraba": 2,
  };
  List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
  ];

  Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  DbHelper dbHelper;
  int key = 0;
  @override
  void initState() {
    super.initState();
    getUserData();

    dbHelper = DbHelper();
  }

  String name;
  String nin;
  LegendShape _legendShape = LegendShape.Circle;
  LegendPosition _legendPosition = LegendPosition.right;
  final _dialogKey = new GlobalKey<State>();

  Future<void> getUserData() async {
    final SharedPreferences sp = await _pref;

    setState(() {
      name = sp.getString("user_name");
      nin = sp.getString("user_id");
      // _conUserId.text = sp.getString("user_id");
      // _conDelUserId.text = sp.getString("user_id");
      // _conUserName.text = sp.getString("user_name");
      // _conEmail.text = sp.getString("email");
      // _conPassword.text = sp.getString("password");
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final complaintProvider =
        Provider.of<ComplaintProvider>(context, listen: false);
    final navigationProvider = Provider.of<NavigationProvider>(context);

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 50.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Welcome ',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${name.toString()}',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: kPrimaryColor,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.minBlockVertical * 5.0,
            ),
            Container(
              width: double.infinity,
              height: 120.0,
              decoration: BoxDecoration(
                color: Color(0xFFFA6A22),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${nin.toString()}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: kWhiteColor,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.minBlockVertical,
                  ),
                  Text(
                    'Nin',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: kWhiteColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.minBlockVertical * 3.0,
            ),
            Container(
              width: double.infinity,
              height: 120.0,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${complaintProvider.numOfComplaint}',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: kWhiteColor,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.minBlockVertical,
                  ),
                  Text(
                    'Number of complaint',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: kWhiteColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.minBlockVertical * 3.0,
            ),
            Text(
              'Top Reported Areas',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: SizeConfig.minBlockVertical * 2.0,
            ),
            nin != null
                ? PieChart(
                    dataMap: dataMap,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 32,
                    chartRadius: MediaQuery.of(context).size.width / 3.2,
                    colorList: colorList,
                    initialAngleInDegree: 0,
                    chartType: ChartType.ring,
                    ringStrokeWidth: 32,
                    centerText: "HYBRID",
                    legendOptions: LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.right,
                      showLegends: true,
                      legendShape: BoxShape.circle,
                      legendTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    chartValuesOptions: ChartValuesOptions(
                      showChartValueBackground: true,
                      showChartValues: true,
                      showChartValuesInPercentage: false,
                      showChartValuesOutside: false,
                      decimalPlaces: 1,
                    ),
                  )
                : CircularProgressIndicator(),
            SizedBox(
              height: SizeConfig.minBlockVertical * 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'History',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AssaultPages.listcomplaint);
                  },
                  child: Text(
                    'See All',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.minBlockVertical * 2.0,
            ),
            _buildHistoryCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryCard(BuildContext context) {
    final _complaintProvider = Provider.of<ComplaintProvider>(context);
    return FutureBuilder<ComplaintModel>(
      // future: _complaintProvider.myComplaint(),
      builder: (context, snapshot) {
        if (snapshot.hasError ||
            snapshot.data == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (1 == 1) {
          return Card(
            child: ListTile(
              title: Text(
                "No history available",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              trailing: Icon(Icons.navigate_next),
            ),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text('Aderibigbe Ester'),
                subtitle: Text('Kwara State'),
                trailing: Text('20/1/2021'),
              ),
            );
          },
        );
      },
    );
  }
}
