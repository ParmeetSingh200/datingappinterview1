
import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';
import 'model/signup_model.dart';
import 'model/signup_model.dart';
import 'model/signup_model.dart';

class Preference_Page extends StatefulWidget {
  const Preference_Page({Key? key}) : super(key: key);

  @override
  State<Preference_Page> createState() => _Preference_PageState();
}

class _Preference_PageState extends State<Preference_Page> {

  bool dataLoaded=false;

  double value=0;

  String _currentSelectedEthnicity = "";
  String _currentSelectedBodyType = "";
  String _currentSelectedPosition = "";


  var _currenciesEthnicity = [
    "Black or African American",
    "Asian",
    "White",
    "American Indian or Alaska Native",
  ];
  var _currenciesBodyType = [
    "Big boned with a sturdy frame",
    "Athletic build",
    "Well defined muscles",
    "Rectangular shaped body",
    "Generally strong",
    "Hourglass",
    "Diamond",
    "Round or oval",
  ];
  var _currenciesPosition = [
    "Top",
    "Bottom",
    "Versatile",
  ];

  String _startValueAge='0';
  String _endValueAge='100';

  RangeValues values = RangeValues(1, 100);
  RangeLabels labels =RangeLabels('1', "100");

  @override
  void initState(){
    GetPreferences();
    value = 0;
    downloadData();
    super.initState();
  }

  Future<void> GetPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    var email = await prefs.getString('email');
    if(email != '' || email != null) {
      print("working");
      var resp = await ApiService.getPrefs(email: email);
      var age_range =await resp["Get Preferences"]["age_range"].toString();
      var ethnicity =await resp["Get Preferences"]["ethnicity"].toString();
      var position =await resp["Get Preferences"]["position"].toString();
      var body_type =await resp["Get Preferences"]["body_type"].toString();
      print(ethnicity);
      print(position);
      print(body_type);

      setState(() {

        var parts = age_range.split('and');
         _startValueAge=parts[0].trim();
        _endValueAge=parts[1].trim();
         values=RangeValues(double.parse(_startValueAge), double.parse(_endValueAge));
          _currentSelectedEthnicity = ethnicity;
        _currentSelectedBodyType = position ;
        _currentSelectedPosition = body_type;
        dataLoaded=true;
        value=1;
      });
    }
  }

  void downloadData(){
    new Timer.periodic(
        Duration(seconds: 2),
            (Timer timer){
          setState(() {
            if(value == 1) {
              timer.cancel();
            }
            else {
              value = value + 0.1;
            }
          });
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:()async {
        print("willpop");
        final prefs = await SharedPreferences.getInstance();
        var email1 = await prefs.getString('email');
        String? email = email1;
        String Age = "$_startValueAge and $_endValueAge";
        String ethnicity = _currentSelectedEthnicity;
        String position = _currentSelectedBodyType;
        String body_type=_currentSelectedPosition;
        print(Age);
        print(email1);
        print(ethnicity);
        print(position);
        print(body_type);
        var resp =await ApiService.searchConnections(email: email, age_range: Age, ethnicity: ethnicity, position: position, body_type: body_type);
        Fluttertoast.showToast(msg: resp["Add Preferences"]["message"]);
        return true;
      },
      child: Scaffold(
        backgroundColor: Color(0xff35132b),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async{
                final prefs = await SharedPreferences.getInstance();
                var email1 = await prefs.getString('email');
                String? email = email1;
                String Age = "$_startValueAge and $_endValueAge";
                String ethnicity = _currentSelectedEthnicity;
                String position = _currentSelectedBodyType;
                String body_type=_currentSelectedPosition;
                print(Age);
                print(email1);
                print(ethnicity);
                print(position);
                print(body_type);
             var resp =await ApiService.searchConnections(email: email, age_range: Age, ethnicity: ethnicity, position: position, body_type: body_type);
                Navigator.pop(context);
                Fluttertoast.showToast(msg: resp["Add Preferences"]["message"]);

            },
          ),
          titleSpacing: 0,
           leadingWidth: 33,
          centerTitle: false,
          title: Text(
            "Preferences",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xff35132b),
        ),
        body:
            dataLoaded ?
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15,0,0,0),
                child: Text("Age Range",style: TextStyle(color: Colors.white),),
              ),
              SizedBox(height: 10,),
              RangeSlider(
                  divisions: 100,
                  activeColor: Color(0xffdd3953),
                  inactiveColor: Colors.grey,
                  min: 1,
                  max: 100,
                  values: values,
                  labels: labels,
                  onChanged: (value){
                    print("START: ${value.start}, End: ${value.end}");

                    setState(() {
                      values =value;
                      labels =RangeLabels("${value.start.toInt().toString()}", "${value.end.toInt().toString()}");
                      _startValueAge=value.start.toStringAsFixed(0);
                      _endValueAge=value.end.toInt().toString();
                    });
                  }
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14,0,14,0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_startValueAge,style: TextStyle(color: Colors.white),),
                    Text(_endValueAge,style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.fromLTRB(15,0,15,0),
                child: ButtonTheme(
                  // alignedDropdown: true,
                  child: DropdownButtonFormField<String>(
                     icon: Icon(Icons.keyboard_arrow_down,color: Colors.white,),
                    dropdownColor: Colors.black,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      labelText: 'Ethnicity',
                      labelStyle: TextStyle(color: Colors.grey),
                      alignLabelWithHint: true,
                      floatingLabelStyle: TextStyle(color: Colors.grey),
                      // floatingLabelBehavior: FloatingLabelBehavior.auto,
                    ),
                    value: _currentSelectedEthnicity.isNotEmpty
                        ? _currentSelectedEthnicity
                        : null,
                    onChanged: (String? newValue) {
                      setState(() {
                        _currentSelectedEthnicity = newValue!;
                        // state.didChange(newValue);
                      });
                    },
                    items: _currenciesEthnicity.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.fromLTRB(15,0,15,0),
                child: ButtonTheme(
                  // alignedDropdown: true,
                  child: DropdownButtonFormField<String>(
                    icon: Icon(Icons.keyboard_arrow_down,color: Colors.white,),
                    dropdownColor: Colors.black,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      labelText: 'Body Type',
                      labelStyle: TextStyle(color: Colors.grey),
                      alignLabelWithHint: true,
                      floatingLabelStyle: TextStyle(color: Colors.grey),
                    ),
                    value: _currentSelectedBodyType.isNotEmpty
                        ? _currentSelectedBodyType
                        : null,
                    onChanged: (String? newValue) {
                      setState(() {
                        _currentSelectedBodyType = newValue!;
                        // state.didChange(newValue);
                      });
                    },
                    items: _currenciesBodyType.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.fromLTRB(15,0,15,0),
                child: ButtonTheme(
                  // alignedDropdown: true,
                  child: DropdownButtonFormField<String>(
                    icon: Icon(Icons.keyboard_arrow_down,color: Colors.white,),
                    dropdownColor: Colors.black,
                    decoration: InputDecoration(
                       contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      labelText: 'Position',
                      labelStyle: TextStyle(color: Colors.grey),
                      alignLabelWithHint: true,
                      floatingLabelStyle: TextStyle(color: Colors.grey),
                    ),
                    value: _currentSelectedPosition.isNotEmpty
                        ? _currentSelectedPosition
                        : null,
                    onChanged: (String? newValue) {
                      setState(() {
                        _currentSelectedPosition = newValue!;
                        // state.didChange(newValue);
                      });
                    },
                    items: _currenciesPosition.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        )
                :  Center(
                  child: Container(
              margin: EdgeInsets.all(20),
              child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                  color: Colors.purple,
                  strokeWidth: 5,
              ),
            ),
                ),
      ),
    );
  }
}
