import 'dart:async';

import 'package:assault/helpers/DbHelper.dart';
import 'package:assault/models/complaint_model.dart';
import 'package:assault/providers/complaint_provider.dart';
import 'package:assault/ui/core/alert.dart';
import 'package:assault/ui/core/custom_appbar.dart';
import 'package:assault/ui/core/dialogs.dart';
import 'package:assault/ui/core/input_box.dart';
import 'package:assault/ui/core/show_snicks.dart';
import 'package:assault/ui/core/size_config.dart';
import 'package:assault/ui/core/solid_button.dart';
import 'package:assault/ui/core/styles.dart';
import 'package:assault/ui/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddComplaintScreenTwo extends StatefulWidget {
  final ComplaintModel complaintModel;
  AddComplaintScreenTwo({this.complaintModel});

  @override
  _AddComplaintScreenTwoState createState() => _AddComplaintScreenTwoState();
}

class _AddComplaintScreenTwoState extends State<AddComplaintScreenTwo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _townController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _dialogKey = new GlobalKey<State>();

  bool _serviceEnabled;
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  submit() async {
    String town = _townController.text;
    String city = _cityController.text;
    String state = _stateController.text;
    String des = _descriptionController.text;

    if (_formKey.currentState.validate()) {
      if (town == '' || city == '' || state == '' || des == '') {
        Dialogs.showLoadingDialog(context, key: _dialogKey);

        Timer(Duration(seconds: 2), () {
          Navigator.of(context).pop();
          alertDialog(context, 'Fields cannot be empty');
        });
      } else {
        _formKey.currentState.save();

        ComplaintModelL uModel = ComplaintModelL(
            town: town, city: city, state: state, description: des);
        await dbHelper.insertComplainttwo(uModel).then((userData) {
          Dialogs.showLoadingDialog(context, key: _dialogKey);

          Timer(Duration(seconds: 2), () {
            Navigator.of(context).pop();
            alertDialog(context, "Successfully Saved");
            // Navigator.pushNamed(context, AssaultPages.login);
          });
        }).catchError((error) {
          print(error);
          Dialogs.showLoadingDialog(context, key: _dialogKey);

          Timer(Duration(seconds: 2), () {
            Navigator.of(context).pop();
            alertDialog(context, "Complaint Logged Successfully");
            Navigator.pushReplacementNamed(context, AssaultPages.home);
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final complaintProvider = Provider.of<ComplaintProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 50.0,
          ),
          child: Column(
            children: [
              CustomAppBar(
                title: 'Add Location',
              ),
              SizedBox(
                height: SizeConfig.minBlockVertical * 3.0,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    InputBox(
                      controller: _townController,
                      validator: (value) {
                        if (value.trim().isEmpty)
                          return 'Full Name cannot be empty';
                        return null;
                      },
                      borderSide: BorderSide(
                        color: kSecondaryBorder,
                      ),
                      labelText: 'Town',
                    ),
                    SizedBox(
                      height: SizeConfig.minBlockVertical * 5.0,
                    ),
                    InputBox(
                      controller: _cityController,
                      validator: (value) {
                        if (value.trim().isEmpty)
                          return 'Neighbourhood cannot be empty';
                        return null;
                      },
                      borderSide: BorderSide(
                        color: kSecondaryBorder,
                      ),
                      labelText: 'Neighbourhood',
                    ),
                    SizedBox(
                      height: SizeConfig.minBlockVertical * 5.0,
                    ),
                    InputBox(
                      controller: _stateController,
                      validator: (value) {
                        if (value.trim().isEmpty)
                          return 'State cannot be empty';
                        return null;
                      },
                      borderSide: BorderSide(
                        color: kSecondaryBorder,
                      ),
                      labelText: 'State',
                    ),
                    SizedBox(
                      height: SizeConfig.minBlockVertical * 5.0,
                    ),
                    InputBox(
                      controller: _descriptionController,
                      borderSide: BorderSide(
                        color: kSecondaryBorder,
                      ),
                      labelText: 'More Description',
                      inputType: TextInputType.text,
                    ),
                    SizedBox(
                      height: SizeConfig.minBlockVertical * 5.0,
                    ),
                    SolidButton(
                      text: 'Submit',
                      onPressed: submit,
                      color: kPrimaryColor,
                      textColor: Colors.white,
                    ),
                    SizedBox(
                      height: SizeConfig.minBlockVertical,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
