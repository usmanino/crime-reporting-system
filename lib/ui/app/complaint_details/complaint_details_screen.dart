import 'package:assault/helpers/DbHelper.dart';
import 'package:assault/models/complaint_model.dart';
import 'package:assault/providers/complaint_provider.dart';
import 'package:assault/ui/core/custom_appbar.dart';
import 'package:assault/ui/core/size_config.dart';
import 'package:assault/ui/core/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComplaintDetailsScreen extends StatefulWidget {
  final String complaintId;
  ComplaintDetailsScreen({this.complaintId});

  @override
  _ComplaintDetailsScreenState createState() => _ComplaintDetailsScreenState();
}

class _ComplaintDetailsScreenState extends State<ComplaintDetailsScreen> {
  var db;

  @override
  void initState() {
    super.initState();
    db = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    // final complaintProvider = Provider.of<ComplaintProvider>(context);
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 50.0,
        ),
        child: Column(
          children: [
            CustomAppBar(
              title: 'Complaint Details',
            ),
            SizedBox(
              height: SizeConfig.minBlockVertical * 3.0,
            ),
            FutureBuilder(
              future: db.getUserComplaintTwo(widget.complaintId),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError || snapshot.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Expanded(
                  child: ListView(
                    children: [
                      Card(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('Full Name'),
                              subtitle:
                              Text('${snapshot.data[0]['full_name']}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                  vertical: 10.0
                              ),
                              child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Gender'),
                                  Text('${snapshot.data[0]['gender']}'),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                vertical: 10.0
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Age'),
                                  Text('${snapshot.data[0]['age']}'),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 10.0
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Height'),
                                  Text('${snapshot.data[0]['height']}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.minBlockVertical * 2.0,
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Description'),
                          subtitle:
                              Text('${snapshot.data[0]['description']}'),
                          trailing: Text(
                              '${snapshot.data[0]['date']}'),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.minBlockVertical * 2.0,
                      ),
                      Card(
                        child: ListTile(
                          title: Text('City or Locality'),
                          subtitle: Text(
                              '${snapshot.data[0]['town']}, ${snapshot.data[0]['city']}, ${snapshot.data[0]['state'] }'),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.minBlockVertical * 2.0,
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Ethnicity'),
                          subtitle: Text(
                              '${snapshot.data[0]['ethnicity']}'),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.minBlockVertical * 2.0,
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Skin Color'),
                          subtitle: Text(
                              '${snapshot.data[0]['skin_color']}'),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.minBlockVertical * 2.0,
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Eye Color'),
                          subtitle: Text(
                              '${snapshot.data[0]['eye_colour']}'),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.minBlockVertical * 2.0,
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Hair Color'),
                          subtitle: Text(
                              '${snapshot.data[0]['hair_Color']}'),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.minBlockVertical * 2.0,
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Tattoo Description'),
                          subtitle: Text(
                              '${snapshot.data[0]['tattoo_Description']}'),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.minBlockVertical * 2.0,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),

      // Container(
      //   margin: EdgeInsets.symmetric(
      //     horizontal: 20.0,
      //     vertical: 50.0,
      //   ),
      //   child: FutureBuilder(
      //       //  future: complaintProvider.complaintDetails(widget.complaintId),
      //       builder: (context, snapshot) {
      //     if (snapshot.hasError ||
      //         snapshot.data == null ||
      //         snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     return Column(
      //       children: [
      //         CustomAppBar(
      //           title: 'Complaint Details',
      //         ),
      //         SizedBox(
      //           height: SizeConfig.minBlockVertical * 3.0,
      //         ),
      //         Expanded(
      //           child: Column(
      //             children: [
      //               Container(
      //                 width: double.infinity,
      //                 height: 120.0,
      //                 decoration: BoxDecoration(
      //                   color: kPrimaryColor,
      //                   borderRadius: BorderRadius.circular(20.0),
      //                 ),
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   crossAxisAlignment: CrossAxisAlignment.center,
      //                   children: [
      //                     Text(
      //                       '${snapshot.data?.fullName}',
      //                       style: TextStyle(
      //                         fontSize: 25.0,
      //                         fontWeight: FontWeight.bold,
      //                         color: kWhiteColor,
      //                       ),
      //                     ),
      //                     SizedBox(
      //                       height: SizeConfig.minBlockVertical,
      //                     ),
      //                     Text(
      //                       '${snapshot.data?.gender.toString()}',
      //                       style: TextStyle(
      //                         fontSize: 16.0,
      //                         color: kWhiteColor,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: SizeConfig.minBlockVertical * 3.0,
      //               ),
      //               Expanded(
      //                 child: ListView(
      //                   children: [
      //                     Card(
      //                       child: ListTile(
      //                         title: Text('Description'),
      //                         subtitle: Text(
      //                             '${snapshot.data?.description.toString()}'),
      //                         trailing: Text(
      //                             '${snapshot.data?.date.toString().split("T")[0]}'),
      //                       ),
      //                     ),
      //                     SizedBox(
      //                       height: SizeConfig.minBlockVertical * 2.0,
      //                     ),
      //                     Card(
      //                       child: ListTile(
      //                         title: Text('Neighbourhood'),
      //                         subtitle: Text(
      //                             '${snapshot.data?.town.toString().split("T")[0]}'),
      //                       ),
      //                     ),
      //                     SizedBox(
      //                       height: SizeConfig.minBlockVertical * 2.0,
      //                     ),
      //                     Card(
      //                       child: ListTile(
      //                         title: Text('City or Locality'),
      //                         subtitle: Text(
      //                             '${snapshot.data?.city.toString().split("T")[0]}'),
      //                       ),
      //                     ),
      //                     SizedBox(
      //                       height: SizeConfig.minBlockVertical * 2.0,
      //                     ),
      //                     Card(
      //                       child: ListTile(
      //                         title: Text('Ethnicity'),
      //                         subtitle: Text(
      //                             '${snapshot.data?.ethnicity.toString().split("T")[0]}'),
      //                       ),
      //                     ),
      //                     SizedBox(
      //                       height: SizeConfig.minBlockVertical * 2.0,
      //                     ),
      //                     Card(
      //                       child: ListTile(
      //                         title: Text('State'),
      //                         subtitle: Text(
      //                             '${snapshot.data?.state.toString().split("T")[0]}'),
      //                       ),
      //                     ),
      //                     SizedBox(
      //                       height: SizeConfig.minBlockVertical * 2.0,
      //                     ),
      //                     Card(
      //                       child: ListTile(
      //                         title: Text('Eye Color'),
      //                         subtitle: Text(
      //                             '${snapshot.data?.eyeColor.toString().split("T")[0]}'),
      //                       ),
      //                     ),
      //                     SizedBox(
      //                       height: SizeConfig.minBlockVertical * 2.0,
      //                     ),
      //                     Card(
      //                       child: ListTile(
      //                         title: Text('Hair Color'),
      //                         subtitle: Text(
      //                             '${snapshot.data?.state.toString().split("T")[0]}'),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ],
      //     );
      //   }),
      // ),
    );
  }
}
