import 'dart:async';
import 'package:assault/helpers/DbHelper.dart';
import 'package:assault/models/complaint_model.dart';
import 'package:assault/providers/complaint_provider.dart';
import 'package:assault/ui/app/complaint/add_complaint_screen_two.dart';
import 'package:assault/ui/core/alert.dart';
import 'package:assault/ui/core/custom_appbar.dart';
import 'package:assault/ui/core/dialogs.dart';
import 'package:assault/ui/core/input_box.dart';
import 'package:assault/ui/core/select_box.dart';
import 'package:assault/ui/core/size_config.dart';
import 'package:assault/ui/core/solid_button.dart';
import 'package:assault/ui/core/styles.dart';
import 'package:assault/ui/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AddComplaintScreen extends StatefulWidget {
  AddComplaintScreen();

  @override
  _AddComplaintScreenState createState() => _AddComplaintScreenState();
}

class _AddComplaintScreenState extends State<AddComplaintScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _tattoDescriptionController =
      TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _eyeController = TextEditingController();
  final TextEditingController _skinController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _ethnicityController = TextEditingController();
  final TextEditingController _hairController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime _date = DateTime.now();
  final _dateFormatter = DateFormat('MMM dd, yyyy');

  final _dialogKey = new GlobalKey<State>();

  bool _serviceEnabled;
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
    _dateController.text = _dateFormatter.format(_date);
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  submit() async {
    String facial = "Yes";
    // _nameController.text = 'test test';
    // _tattoDescriptionController.text = 'very bad';
    // _heightController.text = '12';
    // _ageController.text = '21';
    // _eyeController.text = 'white';
    // _skinController.text = 'black';
    // _genderController.text = 'male';
    // _ethnicityController.text = 'Cool';
    // _hairController.text = 'black';
    // _dateController.text = 'Jan 20,2022';

    String name = _nameController.text;
    String tdes = _tattoDescriptionController.text;
    String heightt = _heightController.text;
    String age = _ageController.text;
    String eye = _eyeController.text;
    String skin = _skinController.text;
    String gen = _genderController.text;
    String eth = _ethnicityController.text;
    String hair = _hairController.text;
    String ondate = _dateController.text;

    if (_formKey.currentState.validate()) {
      if (name == '' ||
          tdes == '' ||
          heightt == '' ||
          age == '' ||
          eye == '' ||
          skin == '' ||
          gen == '' ||
          eth == '' ||
          hair == '') {
        Dialogs.showLoadingDialog(context, key: _dialogKey);

        Timer(Duration(seconds: 2), () {
          Navigator.of(context).pop();
          alertDialog(context, 'Fields cannot be empty');
        });
      } else {
        _formKey.currentState.save();

        // ComplaintModel uModel = ComplaintModel(
        //   name,
        //   tdes,
        //   age,
        //   eye,
        //   skin,
        //   gen,
        //   facial,
        //   eth,
        //   hair,
        //   heightt,
        //   ondate,
        // );
        // await dbHelper.saveDatatoCrime(uModel).then((userData) {
        //   Dialogs.showLoadingDialog(context, key: _dialogKey);
        //
        //   Timer(Duration(seconds: 2), () {
        //     Navigator.of(context).pop();
        //     alertDialog(context, "Successfully Saved");
        //     Navigator.pushNamed(context, AssaultPages.addcomplaintwo);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddComplaintScreenTwo(
              fullName: name,
              tattooDescription: tdes,
              ageApprox: age,
              eyeColor: eye,
              skinColor: skin,
              gender: gen,
              facialHair: facial,
              ethnicity: eth,
              hairColor: hair,
              height: heightt,
              date: ondate,
            ),
          ),
        );
        //   });
        // }).catchError((error) {
        //   print(error);
        //   Dialogs.showLoadingDialog(context, key: _dialogKey);
        //
        //   Timer(Duration(seconds: 2), () {
        //     Navigator.of(context).pop();
        //     alertDialog(context, "Opps");
        //   });
        // });
      }
    }
  }

  _handleDatePicker() async {
    final DateTime date = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _dateController.text = _dateFormatter.format(date);
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
                title: 'Add Complaint',
              ),
              SizedBox(
                height: SizeConfig.minBlockVertical * 3.0,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    InputBox(
                      controller: _nameController,
                      validator: (value) {
                        if (value.trim().isEmpty)
                          return 'Full Name cannot be empty';
                        return null;
                      },
                      borderSide: BorderSide(
                        color: kSecondaryBorder,
                      ),
                      labelText: 'Full Name',
                    ),
                    SizedBox(
                      height: SizeConfig.minBlockVertical * 5.0,
                    ),
                    InputBox(
                      controller: _genderController,
                      validator: (value) {
                        if (value.trim().isEmpty)
                          return 'Gender cannot be empty';
                        return null;
                      },
                      borderSide: BorderSide(
                        color: kSecondaryBorder,
                      ),
                      labelText: 'Gender',
                    ),
                    SizedBox(
                      height: SizeConfig.minBlockVertical * 5.0,
                    ),
                    InputBox(
                      controller: _heightController,
                      validator: (value) {
                        if (value.trim().isEmpty)
                          return 'Height cannot be empty';
                        return null;
                      },
                      borderSide: BorderSide(
                        color: kSecondaryBorder,
                      ),
                      labelText: 'Height',
                      inputType: TextInputType.number,
                    ),
                    SizedBox(
                      height: SizeConfig.minBlockVertical * 5.0,
                    ),
                    InputBox(
                      controller: _ageController,
                      validator: (value) {
                        if (value.trim().isEmpty) return 'Age cannot be empty';
                        return null;
                      },
                      borderSide: BorderSide(
                        color: kSecondaryBorder,
                      ),
                      labelText: 'Age',
                    ),
                    SizedBox(
                      height: SizeConfig.minBlockVertical * 5.0,
                    ),
                    InputBox(
                      controller: _eyeController,
                      validator: (value) {
                        if (value.trim().isEmpty) return 'choose eye color';
                        return null;
                      },
                      borderSide: BorderSide(
                        color: kSecondaryBorder,
                      ),
                      labelText: 'Eye color',
                    ),
                    SizedBox(
                      height: SizeConfig.minBlockVertical * 5.0,
                    ),
                    if (1 == 1)
                      InputBox(
                        controller: _skinController,
                        validator: (value) {
                          if (value.trim().isEmpty) return 'choose skin color';
                          return null;
                        },
                        borderSide: BorderSide(
                          color: kSecondaryBorder,
                        ),
                        labelText: 'Skin Color',
                      ),
                    SizedBox(
                      height: SizeConfig.minBlockVertical * 5.0,
                    ),
                    InputBox(
                      controller: _ethnicityController,
                      validator: (value) {
                        if (value.trim().isEmpty)
                          return 'Ethnicity cannot be empty';
                        return null;
                      },
                      borderSide: BorderSide(
                        color: kSecondaryBorder,
                      ),
                      labelText: 'Ethnicity',
                    ),
                    SizedBox(
                      height: SizeConfig.minBlockVertical * 5.0,
                    ),
                    InputBox(
                      controller: _hairController,
                      validator: (value) {
                        if (value.trim().isEmpty)
                          return 'Hair color cannot be empty';
                        return null;
                      },
                      borderSide: BorderSide(
                        color: kSecondaryBorder,
                      ),
                      labelText: 'Hair Color',
                    ),
                    SizedBox(
                      height: SizeConfig.minBlockVertical * 5.0,
                    ),
                    InputBox(
                      onTap: _handleDatePicker,
                      readOnly: true,
                      controller: _dateController,
                      validator: (value) {
                        if (value.trim().isEmpty) return 'Age cannot be empty';
                        return null;
                      },
                      borderSide: BorderSide(
                        color: kSecondaryBorder,
                      ),
                      labelText: 'Date',
                    ),
                    SizedBox(
                      height: SizeConfig.minBlockVertical * 2.0,
                    ),
                    SizedBox(
                      height: SizeConfig.minBlockVertical * 2.0,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: complaintProvider.hasTatoo,
                          onChanged: (value) {
                            complaintProvider.hasTatoo = value;
                          },
                        ),
                        SizedBox(
                          width: SizeConfig.minBlockVertical * 2.0,
                        ),
                        Text(
                          'Has Tatto',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                    if (complaintProvider.hasTatoo) ...[
                      SizedBox(
                        height: SizeConfig.minBlockVertical * 2.0,
                      ),
                      InputBox(
                        controller: _tattoDescriptionController,
                        validator: (value) {
                          if (value.trim().isEmpty)
                            return 'Tatto Description cannot be empty';
                          return null;
                        },
                        borderSide: BorderSide(
                          color: kSecondaryBorder,
                        ),
                        labelText: 'Tatto Description',
                        inputType: TextInputType.text,
                      ),
                    ] else
                      Container(),
                    SizedBox(
                      height: SizeConfig.minBlockVertical * 5.0,
                    ),
                    SolidButton(
                      text: 'Next',
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
