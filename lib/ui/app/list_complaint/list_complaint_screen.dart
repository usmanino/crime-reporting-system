
import 'package:assault/helpers/DbHelper.dart';
import 'package:assault/models/complaint_model.dart';
import 'package:assault/providers/complaint_provider.dart';
import 'package:assault/ui/app/complaint_details/complaint_details_screen.dart';
import 'package:assault/ui/core/custom_appbar.dart';
import 'package:assault/ui/core/size_config.dart';
import 'package:assault/ui/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListComplaintScreen extends StatefulWidget {
  ListComplaintScreen();

  @override
  _ListComplaintScreenState createState() => _ListComplaintScreenState();
}

class _ListComplaintScreenState extends State<ListComplaintScreen> {
  var db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    final _complaintProvider =
        Provider.of<ComplaintProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 50.0,
            ),
            child: Column(
        children: [
            CustomAppBar(
              title: 'My Complaint',
            ),
            SizedBox(
              height: SizeConfig.minBlockVertical * 3.0,
            ),
            FutureBuilder(
                future: db.getUserComplaint(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              // Navigator.pushNamed(context, AssaultPages.complaindetails);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ComplaintDetailsScreen(
                                    complaintId: snapshot.data[index]['id'].toString(),
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: Text(
                                  snapshot.data[index]['full_name'].toString()),
                              title: Text(
                                  snapshot.data[index]['description'].toString()),
                              subtitle:
                                  Text(snapshot.data[index]['date'].toString()),
                            ),
                          );
                        },
                      ),
                    );
                  }
                }),
        ],
      ),
          )

          // FutureBuilder<ComplaintModel>(
          //     //future: _complaintProvider.myComplaint(),
          //     builder: (context, snapshot) {
          //   if (snapshot.hasError ||
          //       snapshot.connectionState == ConnectionState.waiting) {
          //     return Center(
          //       child: CircularProgressIndicator(),
          //     );
          //   } else if (1 == 1 || 1 == 1) {
          //     return Container(
          //       margin: EdgeInsets.symmetric(
          //         horizontal: 20.0,
          //         vertical: 50.0,
          //       ),
          //       child: Column(
          //         children: [
          //           CustomAppBar(
          //             title: 'My Complaint',
          //           ),
          //           SizedBox(
          //             height: SizeConfig.minBlockVertical * 3.0,
          //           ),
          //
          //           Card(
          //             child: ListTile(
          //               title: Text('No Complaint Available'),
          //               trailing: Icon(Icons.navigate_next),
          //             ),
          //           ),
          //         ],
          //       ),
          //     );
          //   }
          //   return Container(
          //     margin: EdgeInsets.symmetric(
          //       horizontal: 20.0,
          //       vertical: 50.0,
          //     ),
          //     child: Column(
          //       children: [
          //         CustomAppBar(
          //           title: 'My Complaint',
          //         ),
          //         SizedBox(
          //           height: SizeConfig.minBlockVertical * 3.0,
          //         ),
          //         Expanded(
          //           child: ListView.builder(
          //               // itemCount: snapshot.data.complaintListModel.length,
          //               itemBuilder: (context, index) {
          //                 return Card(
          //                   child: ListTile(
          //                     onTap: () {
          //                       Navigator.of(context)
          //                           .pushNamed(AssaultPages.complaindetails);
          //                     },
          //                     // title: Text(
          //                         // '${snapshot.data.complaintListModel[index].fullName.toString()}'
          //                     // ),
          //                     // subtitle: Text(
          //                     //     '${snapshot.data.complaintListModel[index].state.toString()}'),
          //                     // trailing: Text(
          //                     //     '${snapshot.data.complaintListModel[index].date.toString().split('T')[0]}'),
          //                   ),
          //                 );
          //               }),
          //         ),
          //       ],
          //     ),
          //   );
          // }),
          ),
    );
  }
}
