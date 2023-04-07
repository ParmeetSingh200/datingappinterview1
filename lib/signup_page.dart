import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:gaydatingapp/DBHelper.dart';
import 'package:gaydatingapp/model/signup_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'people_page.dart';
import 'api_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: capitalize(newValue.text),
      selection: newValue.selection,
    );
  }
}

String capitalize(String value) {
  if (value.trim().isEmpty) return "";
  return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
}

String validateEmail(String value) {
  Pattern pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  // Pattern pattern1=r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]";
  RegExp regex = new RegExp(pattern.toString());
  if (!regex.hasMatch(value) && regex != null)
    return 'EnterValid';
  else {
    return "lost";
  }
  ;
}

class _SignupPageState extends State<SignupPage> {
  // RegExp(r'^[a-z A-Z]+$')

  RegExp rex = new RegExp(r'^[a-z A-Z]+$');

  String _currentSelectedGender = "";

  @override
  void dispose() {
    _dobController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _passwordFocusNode.dispose();
    _confirmpasswordFocusNode.dispose();

    super.dispose();
  }

  var _currencies = [
    "Men looking for Men",
  ];

  late bool _passwordtoggle = true;
  late bool _confirmpasswordtoggle = true;

  String useremail = '';

  DateTime? _chosenDateTime;
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController = TextEditingController();

  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmpasswordFocusNode = FocusNode();

  void _showDatePicker(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 480,
              // color: const Color.fromARGB(255, 255, 255, 255),
              color: Color(0xff2f1629),
              child: Column(
                children: [
                  SizedBox(
                    height: 400,
                    // width: 300,
                    child: CupertinoTheme(
                      data: CupertinoThemeData(

                          textTheme: CupertinoTextThemeData(
                          dateTimePickerTextStyle: TextStyle(color: Colors.white,fontSize: 18),
                          ),
                          ),
                      child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          initialDateTime: DateTime.now(),
                          maximumDate: DateTime.now(),
                          onDateTimeChanged: (val) {
                            setState(() {
                              _chosenDateTime = val;
                            });
                          }),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoButton(
                        child: const Text('OK'),
                        onPressed: () {
                          DateFormat.yMMMd().format(_chosenDateTime!);
                          String chdt = _chosenDateTime.toString();
                          String dt = chdt;
                          final dateList = dt.split(" ");
                          print(dateList[0]);
                          _dobController.text = dateList[0];
                          Navigator.of(ctx).pop();
                        },
                        // onPressed: () => Navigator.of(ctx).pop(),
                      ),
                      CupertinoButton(child: Text("Cancel"),
                          onPressed: (){
                            Navigator.of(ctx).pop();
                          })
                    ],

                  ),

                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      // backgroundColor:Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            if (FocusScope.of(context).isFirstFocus) {
              FocusScope.of(context).unfocus();
            }
            Navigator.of(context).pop();
          },
        ),
        title: Text("SIGN UP",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            )),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        // elevation:0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            // colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.5), BlendMode.dstATop),
            image: AssetImage("assets/images/login-bkgrd.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisSize: MainAxisSize.max,

              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 140,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButtonFormField<String>(
                      icon: SizedBox.shrink(),
                      dropdownColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        labelText: 'I am',
                        labelStyle: TextStyle(color: Colors.grey),
                        alignLabelWithHint: true,
                        floatingLabelStyle: TextStyle(color: Color(0xffdd3953)),
                      ),
                      value: _currentSelectedGender.isNotEmpty
                          ? _currentSelectedGender
                          : null,
                        onChanged: (String? newValue) {
                        setState(() {
                          _currentSelectedGender = newValue!;
                          print(_currentSelectedGender);
                          // state.didChange(newValue);
                        });
                      },
                      items: _currencies.map((String value) {
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
                  // child: TextField(
                  //   decoration: InputDecoration(
                  //     enabledBorder: UnderlineInputBorder(
                  //         borderSide: BorderSide(
                  //       width: 1,
                  //       color: Colors.grey,
                  //     )),
                  //     labelText: 'I am',
                  //     labelStyle: TextStyle(color: Colors.grey),
                  //     floatingLabelStyle: TextStyle(color: Color(0xffdd3953)),
                  //     // hintText: 'Enter Your Email'
                  //   ),
                  // ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 25, 20, 5),
                  child: TextField(
                    readOnly: true,
                    style: TextStyle(color: Colors.white),
                    controller: _dobController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                      suffixIcon: InkWell(
                        onTap: () {
                          // _selectDate();
                          _showDatePicker(context);
                        },
                        child: Icon(
                          Icons.calendar_month_sharp,
                          color: Color(0xffdd3953),
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        width: 1,
                        color: Colors.grey,
                      )),
                      labelText: 'Date of Birth',
                      labelStyle: TextStyle(color: Colors.grey),
                      alignLabelWithHint: true,
                      floatingLabelStyle: TextStyle(color: Color(0xffdd3953)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 25, 20, 5),
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    maxLength: 70,
                    inputFormatters: [
                      // UpperCaseTextFormatter(),
                      FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]")),
                    ],
                    controller: _nameController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        width: 1,
                        color: Colors.grey,
                      )),
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.grey),
                      alignLabelWithHint: true,
                      floatingLabelStyle: TextStyle(color: Color(0xffdd3953)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 25, 20, 5),
                  child: TextField(
                    controller: _emailController,
                    style: TextStyle(color: Colors.white),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        width: 1,
                        color: Colors.grey,
                      )),
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.grey),
                      alignLabelWithHint: true,
                      floatingLabelStyle: TextStyle(color: Color(0xffdd3953)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 25, 20, 5),
                  child: TextField(
                    onEditingComplete: () {
                      FocusScope.of(context)
                          .requestFocus(_confirmpasswordFocusNode);
                    },
                    focusNode: _passwordFocusNode,
                    controller: _passwordController,
                    style: TextStyle(color: Colors.white),
                    textInputAction: TextInputAction.next,
                    obscureText: _passwordtoggle,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                      suffixIcon: IconButton(
                          color: Color(0xffdd3953),
                          icon: Icon(
                            _passwordtoggle ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordtoggle = !_passwordtoggle;
                            });
                          }

                          // color: Color(0xffdd3953),
                          ),
                      suffixIconConstraints: BoxConstraints(
                        minHeight: 20,
                        minWidth: 20,
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        width: 1,
                        color: Colors.grey,
                      )),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.grey),
                      alignLabelWithHint: true,
                      floatingLabelStyle: TextStyle(color: Color(0xffdd3953)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 25, 20, 5),
                  child: TextField(
                    focusNode: _confirmpasswordFocusNode,
                    controller: _confirmpasswordController,
                    style: TextStyle(color: Colors.white),
                    // textInputAction: TextInputAction.next,
                    obscureText: _confirmpasswordtoggle,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                      suffixIcon: IconButton(
                          color: Color(0xffdd3953),
                          icon: Icon(
                            _confirmpasswordtoggle ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _confirmpasswordtoggle = !_confirmpasswordtoggle;
                            });
                          }
                          // color: Color(0xffdd3953),
                          ),
                      // suffixIcon: ImageIcon(
                      //   AssetImage('assets/images/ic-eye-disable.png'),
                      //   color: Color(0xffdd3953),
                      // ),
                      suffixIconConstraints: BoxConstraints(
                        minHeight: 20,
                        minWidth: 20,
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        width: 1,
                        color: Colors.grey,
                      )),
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(color: Colors.grey),
                      alignLabelWithHint: true,
                      floatingLabelStyle: TextStyle(color: Color(0xffdd3953)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 52,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 25, 20, 5),
                  child: SizedBox(
                    height: 37,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xffdd3953),
                        ),
                        onPressed: () async {
                          if (_currentSelectedGender.isEmpty ||
                              _currentSelectedGender == null)
                          // || _dobController.text.trim().isEmpty || _nameController.text.trim().isEmpty || _emailController.text.trim().isEmpty || _passwordController.text.trim().isEmpty || _confirmpasswordController.text.trim().isEmpty)
                          {
                            print("Gender");
                            // print(_currentSelectedGender);
                            // Fluttertoast.showToast(
                            //   msg: 'Please fill all the fields',
                            //   backgroundColor: Color(0xff2f1629),
                            // );
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return SizedBox(
                                    width: double.infinity,
                                    height: 200,
                                    // width : MediaQuery.of(context).size.width,
                                    child: AlertDialog(
                                      // contentPadding:EdgeInsets.zero,
                                      // title: Text("Delete Account",style: TextStylolor: Colors.white),textAlign: TextAlign.center,),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6.0))),
                                      backgroundColor: Colors.black45,
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        // mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 5, 0, 0),
                                            child: Text("Gay Dating App",
                                                style: TextStyle(
                                                    color: Color(0xffdd3953),
                                                    fontSize: 18)),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                            child: Text('Please select gender',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15),
                                                textAlign: TextAlign.left),
                                          ),
                                          SizedBox(
                                            height: 35,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "OK",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xffdd3953)),
                                                  ))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          } else if (_dobController.text
                              .trim()
                              .isEmpty) {
                            {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      width: double.infinity,
                                      height: 200,
                                      // width : MediaQuery.of(context).size.width,
                                      child: AlertDialog(
                                        // contentPadding:EdgeInsets.zero,
                                        // title: Text("Delete Account",style: TextStylolor: Colors.white),textAlign: TextAlign.center,),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6.0))),
                                        backgroundColor: Colors.black45,
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 5, 0, 0),
                                              child: Text("Gay Dating App",
                                                  style: TextStyle(
                                                      color: Color(0xffdd3953),
                                                      fontSize: 18)),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 0, 0),
                                              child: Text(
                                                  'Please select your date of birth',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.left),
                                            ),
                                            SizedBox(
                                              height: 35,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      "OK",
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xffdd3953)),
                                                    ))
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            }
                          } else if (_nameController.text
                              .trim()
                              .isEmpty) {
                            {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      width: double.infinity,
                                      height: 200,
                                      // width : MediaQuery.of(context).size.width,
                                      child: AlertDialog(
                                        // contentPadding:EdgeInsets.zero,
                                        // title: Text("Delete Account",style: TextStylolor: Colors.white),textAlign: TextAlign.center,),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6.0))),
                                        backgroundColor: Colors.black45,
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 5, 0, 0),
                                              child: Text("Gay Dating App",
                                                  style: TextStyle(
                                                      color: Color(0xffdd3953),
                                                      fontSize: 18)),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 0, 0),
                                              child: Text(
                                                  'Please enter your name',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.left),
                                            ),
                                            SizedBox(
                                              height: 35,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      "OK",
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xffdd3953)),
                                                    ))
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            }
                          } else if (_emailController.text
                              .trim()
                              .isEmpty) {
                            {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      width: double.infinity,
                                      height: 200,
                                      // width : MediaQuery.of(context).size.width,
                                      child: AlertDialog(
                                        // contentPadding:EdgeInsets.zero,
                                        // title: Text("Delete Account",style: TextStylolor: Colors.white),textAlign: TextAlign.center,),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6.0))),
                                        backgroundColor: Colors.black45,
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 5, 0, 0),
                                              child: Text("Gay Dating App",
                                                  style: TextStyle(
                                                      color: Color(0xffdd3953),
                                                      fontSize: 18)),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 0, 0),
                                              child: Text(
                                                  'Please enter your email address',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.left),
                                            ),
                                            SizedBox(
                                              height: 35,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      "OK",
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xffdd3953)),
                                                    ))
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            }
                          } else if (_passwordController.text
                              .trim()
                              .isEmpty) {
                            {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      width: double.infinity,
                                      height: 200,
                                      // width : MediaQuery.of(context).size.width,
                                      child: AlertDialog(
                                        // contentPadding:EdgeInsets.zero,
                                        // title: Text("Delete Account",style: TextStylolor: Colors.white),textAlign: TextAlign.center,),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6.0))),
                                        backgroundColor: Colors.black45,
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 5, 0, 0),
                                              child: Text("Gay Dating App",
                                                  style: TextStyle(
                                                      color: Color(0xffdd3953),
                                                      fontSize: 18)),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 0, 0),
                                              child: Text(
                                                  'Please enter password',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.left),
                                            ),
                                            SizedBox(
                                              height: 35,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      "OK",
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xffdd3953)),
                                                    ))
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            }
                          } else if (_confirmpasswordController.text
                              .trim()
                              .isEmpty) {
                            {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      width: double.infinity,
                                      height: 200,
                                      // width : MediaQuery.of(context).size.width,
                                      child: AlertDialog(
                                        // contentPadding:EdgeInsets.zero,
                                        // title: Text("Delete Account",style: TextStylolor: Colors.white),textAlign: TextAlign.center,),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6.0))),
                                        backgroundColor: Colors.black45,
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 5, 0, 0),
                                              child: Text("Gay Dating App",
                                                  style: TextStyle(
                                                      color: Color(0xffdd3953),
                                                      fontSize: 18)),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 0, 0),
                                              child: Text(
                                                  'Please enter confirm password',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.left),
                                            ),
                                            SizedBox(
                                              height: 35,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      "OK",
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xffdd3953)),
                                                    ))
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            }
                          } else if (_passwordController.text
                                  .toString()
                                  .trim() !=
                              _confirmpasswordController.text.toString().trim()) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return SizedBox(
                                    width: double.infinity,
                                    height: 200,
                                    // width : MediaQuery.of(context).size.width,
                                    child: AlertDialog(
                                      // contentPadding:EdgeInsets.zero,
                                      // title: Text("Delete Account",style: TextStylolor: Colors.white),textAlign: TextAlign.center,),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6.0))),
                                      backgroundColor: Colors.black45,
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        // mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 5, 0, 0),
                                            child: Text("Gay Dating App",
                                                style: TextStyle(
                                                    color: Color(0xffdd3953),
                                                    fontSize: 18)),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                            child: Text(
                                                'Password and Confirm password do not match',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15),
                                                textAlign: TextAlign.left),
                                          ),
                                          SizedBox(
                                            height: 35,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "OK",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xffdd3953)),
                                                  ))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          } else if (_emailController.text
                                  .trim()
                                  .isNotEmpty ||
                              _emailController.text.trim() == null) {
                            String val = validateEmail(
                                _emailController.text.trim());
                            if (val == 'EnterValid') {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      width: double.infinity,
                                      height: 200,
                                      // width : MediaQuery.of(context).size.width,
                                      child: AlertDialog(
                                        // contentPadding:EdgeInsets.zero,
                                        // title: Text("Delete Account",style: TextStylolor: Colors.white),textAlign: TextAlign.center,),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6.0))),
                                        backgroundColor: Colors.black45,
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 5, 0, 0),
                                              child: Text("Gay Dating App",
                                                  style: TextStyle(
                                                      color: Color(0xffdd3953),
                                                      fontSize: 18)),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 0, 0),
                                              child: Text(
                                                  'Please enter valid email',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.left),
                                            ),
                                            SizedBox(
                                              height: 35,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      "OK",
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xffdd3953)),
                                                    ))
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            } else {
                              print("working");
                              String gender = "Male";
                              String dob = _dobController.text.trim();
                              String name = _nameController.text.trim();
                              String email =
                                  _emailController.text.trim();
                              String password =
                                  _passwordController.text.trim();
                              String confirmpassword =
                                  _confirmpasswordController.text.trim();
                              SignupModel? signupmodel =
                                  await ApiService.postUsers(gender, dob, name,
                                      email, password, confirmpassword);
                              if (signupmodel?.signup?.error == false) {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setString('gender', gender);
                                await prefs.setString('email', email);
                                await prefs.setString('dob', dob);
                                await prefs.setString('name', name);
                                await prefs.setString('email', email);
                                await prefs.setString('password', password);
                              var psswd =  await prefs.getString('password');
                              print(psswd);
                                await prefs.setString(
                                    'confirmpassword', confirmpassword);
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => InboxPage(),
                                  ),
                                );
                              }
                              Fluttertoast.showToast(
                                  msg: signupmodel!.signup!.message ?? '');
                            }
                          }
                        },
                        child: Text("CREATE ACCOUNT")),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(children: <Widget>[
                  Expanded(
                    child: new Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 15.0),
                        child: Divider(
                          color: Colors.grey,
                          height: 10,
                        )),
                  ),
                  Text(
                    "OR",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Expanded(
                    child: new Container(
                        margin: const EdgeInsets.only(left: 15.0, right: 20.0),
                        child: Divider(
                          color: Colors.grey,
                          height: 10,
                        )),
                  ),
                ]),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: SizedBox(
                        height: 37,
                        width: 140,
                        child: ElevatedButton(
                            onPressed: () async {
                              try {
                                 signInWithGoogle(context);
                               } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(e.toString()),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xffff6b6b),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  'assets/images/google.png',
                                  height: 16,
                                  width: 16,
                                ),
                                Text(
                                  "GOOGLE",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ],
                            )
                            // Text("Google",style: TextStyle(color: Colors.black,fontSize: 20),)
                            ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Flexible(
                      child: SizedBox(
                        height: 37,
                        width: 165,
                        child: ElevatedButton(
                            onPressed: () async {
                              try {
                                await signInWithFacebook();

                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => InboxPage(),
                                  ),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(e.toString()),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xff3a559f),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  'assets/images/fb.png',
                                  height: 20,
                                  width: 20,
                                ),
                                // SizedBox(
                                //   width: 25,
                                // ),
                                Text(
                                  "FACEBOOK",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            )
                            // Text("Google",style: TextStyle(color: Colors.black,fontSize: 20),)
                            ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                // padding: EdgeInsets.fromLTRB(20, 10, 18, 20),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text(
                    "Gay App NEVER post anything to your social channels",
                    style: TextStyle(
                        color: Colors.grey, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
      // body: SingleChildScrollView(
      //   child: Center(
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       // mainAxisSize: MainAxisSize.max,
      //
      //       // mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         SizedBox(
      //           height: 20,
      //         ),
      //         Container(
      //           decoration:  BoxDecoration(
      //             // border: Border.all(width: 0, color: Colors.black)
      //           ),
      //           child: Text("SIGN UP",textAlign: TextAlign.center,style:TextStyle(color: Color(0xffff6b6b),fontSize: 20),),
      //         ),
      //         SizedBox(
      //           height: 20,
      //         ),
      //         Padding(
      //           padding: EdgeInsets.fromLTRB(10, 5 ,10, 5),
      //           child: TextField (
      //             decoration: InputDecoration(
      //                 enabledBorder: UnderlineInputBorder(
      //                     borderSide: BorderSide(
      //                       width: 1,
      //                       color: Colors.grey,
      //                     )
      //                 ),
      //                 labelText: 'I am',
      //                 // hintText: 'Enter Your Email'
      //             ),
      //           ),
      //         ),
      //         Padding(
      //           padding: EdgeInsets.fromLTRB(10, 5 ,10, 5),
      //           child: TextField (
      //             decoration: InputDecoration(
      //                 enabledBorder: UnderlineInputBorder(
      //                     borderSide: BorderSide(
      //                       width: 1,
      //                       color: Colors.grey,
      //                     )
      //                 ),
      //                 labelText: 'Date of Birth',
      //                 hintText: 'Enter Your BirthDate'
      //             ),
      //           ),
      //         ),
      //         Padding(
      //           padding: EdgeInsets.fromLTRB(10, 5 ,10, 5),
      //           child: TextField (
      //             decoration: InputDecoration(
      //                 enabledBorder: UnderlineInputBorder(
      //                     borderSide: BorderSide(
      //                       width: 1,
      //                       color: Colors.grey,
      //                     )
      //                 ),
      //                 labelText: 'Name',
      //                 hintText: 'Enter Your Name'
      //             ),
      //           ),
      //         ),
      //         Padding(
      //           padding: EdgeInsets.fromLTRB(10, 5 ,10, 5),
      //           child: TextField (
      //             decoration: InputDecoration(
      //                 enabledBorder: UnderlineInputBorder(
      //                     borderSide: BorderSide(
      //                       width: 1,
      //                       color: Colors.grey,
      //                     )
      //                 ),
      //                 labelText: 'Email',
      //                 hintText: 'Enter Your Email'
      //             ),
      //           ),
      //         ),
      //         Padding(
      //           padding: EdgeInsets.fromLTRB(10, 0 ,10, 5),
      //           child: TextField (
      //             obscureText:true,
      //             decoration: InputDecoration(
      //                 suffixIcon: Icon(Icons.remove_red_eye),
      //                 enabledBorder: UnderlineInputBorder(
      //                     borderSide: BorderSide(
      //                       width: 1,
      //                       color: Colors.grey,
      //                     )
      //                 ),
      //                 labelText: 'Password',
      //                 hintText: 'Enter Your Password'
      //             ),
      //           ),
      //         ),
      //         Padding(
      //           padding: EdgeInsets.fromLTRB(10, 0 ,10, 5),
      //           child: TextField (
      //             obscureText:true,
      //             decoration: InputDecoration(
      //                 suffixIcon: Icon(Icons.remove_red_eye),
      //                 enabledBorder: UnderlineInputBorder(
      //                     borderSide: BorderSide(
      //                       width: 1,
      //                       color: Colors.grey,
      //                     )
      //                 ),
      //                 labelText: 'Confirm Password',
      //                 hintText: 'Enter Password Again'
      //             ),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 25,
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.all(10.0),
      //           child: SizedBox(
      //             height: 45,
      //             width: double.infinity,
      //             child: ElevatedButton(
      //                 style: ElevatedButton.styleFrom(
      //                   primary: Color(0xffff6b6b),),
      //                 onPressed: (){},
      //                 child: Text("CREATE ACCOUNT")),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 20,
      //         ),
      //         Row(children: <Widget>[
      //           Expanded(
      //             child: new Container(
      //                 margin: const EdgeInsets.only(left: 10.0, right: 15.0),
      //                 child: Divider(
      //                   color: Colors.grey,
      //                   height: 10,
      //                 )),
      //           ),
      //
      //           Text("OR",style: TextStyle(color: Colors.grey),),
      //
      //           Expanded(
      //             child: new Container(
      //                 margin: const EdgeInsets.only(left: 15.0, right: 10.0),
      //                 child: Divider(
      //                   color: Colors.grey,
      //                   height: 10,
      //                 )),
      //           ),
      //         ]),
      //         SizedBox(
      //           height: 20,
      //         ),
      //         Padding(
      //           padding: EdgeInsets.fromLTRB(10, 0 ,10, 10 ),
      //           child: Align(
      //             alignment: Alignment.centerLeft,
      //             child: Text("Continue with",
      //               style: TextStyle(color: Colors.black),),
      //           ),
      //         ),
      //         Row(
      //           children: [
      //             Padding(
      //               padding: EdgeInsets.fromLTRB(40, 10 ,10, 10 ),
      //               child: SizedBox(
      //                 height:40 ,
      //                 width:120 ,
      //                 child: ElevatedButton(
      //                     onPressed: () async {
      //                       try {
      //                         await signInWithGoogle();
      //
      //                         Navigator.of(context).pushReplacement(
      //                           MaterialPageRoute(
      //                             builder: (context) => InboxPage(),
      //                           ),
      //                         );
      //                       } catch (e) {
      //                         ScaffoldMessenger.of(context).showSnackBar(
      //                           SnackBar(
      //                             content: Text(e.toString()),
      //                           ),
      //                         );
      //                       }
      //                     },
      //                     style: ElevatedButton.styleFrom(
      //                       primary: Colors.grey,),
      //                     child:Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                       children: [
      //                         Image.asset('assets/images/google-logo.png',height: 20,width: 20,),
      //                         Text("GOOGLE",
      //                           style: TextStyle(color: Colors.black,fontSize: 15),),
      //                       ],
      //                     )
      //                   // Text("Google",style: TextStyle(color: Colors.black,fontSize: 20),)
      //                 ),
      //               ),
      //             ),
      //             Padding(
      //               padding: EdgeInsets.fromLTRB(15, 10 ,10, 10 ),
      //               child: SizedBox(
      //                 height:40 ,
      //                 width:130 ,
      //                 child: ElevatedButton(
      //                     onPressed: (){},
      //                     style: ElevatedButton.styleFrom(
      //                       primary: Color(0xff3a559f),),
      //                     child:Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                       children: [
      //
      //                         Text("f", style: TextStyle(color: Colors.white,fontSize: 20),),
      //                         Text("  FACEBOOK", style: TextStyle(color: Colors.black,fontSize: 15),),
      //                       ],
      //                     )
      //                   // Text("Google",style: TextStyle(color: Colors.black,fontSize: 20),)
      //                 ),
      //               ),
      //             )
      //
      //           ],
      //         ),
      //         SizedBox(
      //           height: 10,
      //         ),
      //         Text("Gay App Never post anything to your social channels",style: TextStyle(color: Colors.black),),
      //         SizedBox(
      //           height: 20,
      //         ),
      //
      //       ],
      //
      //     ),
      //   ),
      // ),
    );
  }

  // _selectDate(BuildContext context) async {
  //   final DateTime? selected = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate,
  //     firstDate: DateTime(2010),
  //     lastDate: DateTime(2025),
  //   );
  //   if (selected != null && selected != selectedDate)
  //     setState(() {
  //       selectedDate = selected;
  //     });
  // }

  void signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    useremail = googleUser!.email;

    // Once signed in, return the UserCredential
    final UserCredential userCredential =
    await FirebaseAuth.instance.signInWithCredential(credential);
    if (userCredential.user != null){
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', useremail!);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => InboxPage(),
        ),
      );
    }
  }

  Future<UserCredential> signInWithFacebook() async {
    // UserCredential user;
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
