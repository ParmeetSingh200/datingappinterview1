import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_service.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({Key? key}) : super(key: key);

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {

  late bool currentpasswordtoggle = true;
  late bool newpasswordtoggle = true;
  late bool confirmpasswordtoggle = true;

  final TextEditingController _currentpasswordController = TextEditingController();
  final TextEditingController _newpasswordController = TextEditingController();
  final TextEditingController _confirmpasswordController = TextEditingController();

  @override
  void dispose() {
    _currentpasswordController.dispose();
    _newpasswordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff35132b),
      appBar: AppBar(
        leading: IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: (){
            if (FocusScope.of(context).isFirstFocus) {
              FocusScope.of(context).unfocus();
            }
            Navigator.of(context).pop(
            );
          },

        ),
        titleSpacing: 0,
        leadingWidth: 33,
        centerTitle: false,
        title: Text("Password",style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xff35132b),
      ),
      body: Column(
        children: [
          SizedBox(height: 70,),
          Padding(
            padding: EdgeInsets.fromLTRB(14, 0, 14, 5),
            child: TextField (
              style: TextStyle(color: Colors.white),
              controller: _currentpasswordController,
              obscureText:currentpasswordtoggle,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                fillColor: Colors.transparent,
                // suffixIcon: Image.asset('assets/images/ic-eye-disable.png',height: 10,width: 10,),
                suffixIcon: IconButton(
                    color: Color(0xffdd3953),
                    icon: Icon(
                      currentpasswordtoggle ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        currentpasswordtoggle = !currentpasswordtoggle;
                      });
                    }
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.white,
                    )
                ),
                labelText: 'Current Password',
                alignLabelWithHint: true,
                labelStyle:TextStyle(color: Colors.grey),
                floatingLabelStyle: TextStyle(color: Color(0xffdd3953)),
                // hintText: 'Enter Your Password'
              ),
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.fromLTRB(14, 0, 14, 5),
            child: TextField (
              style: TextStyle(color: Colors.white),
              controller: _newpasswordController,
              obscureText:newpasswordtoggle,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                fillColor: Colors.transparent,
                // suffixIcon: Image.asset('assets/images/ic-eye-disable.png',height: 10,width: 10,),
                suffixIcon: IconButton(
                    color: Color(0xffdd3953),
                    icon: Icon(
                      newpasswordtoggle ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        newpasswordtoggle = !newpasswordtoggle;
                      });
                    }
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.white,
                    )
                ),
                labelText: 'New Password',
                alignLabelWithHint: true,
                labelStyle:TextStyle(color: Colors.grey),
                floatingLabelStyle: TextStyle(color: Color(0xffdd3953)),
                // hintText: 'Enter Your Password'
              ),
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.fromLTRB(14, 0, 14, 5),
            child: TextField (
              style: TextStyle(color: Colors.white),
              controller: _confirmpasswordController,
              obscureText:confirmpasswordtoggle,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                fillColor: Colors.transparent,
                // suffixIcon: Image.asset('assets/images/ic-eye-disable.png',height: 10,width: 10,),
                suffixIcon: IconButton(
                    color: Color(0xffdd3953),
                    icon: Icon(
                      confirmpasswordtoggle ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        confirmpasswordtoggle = !confirmpasswordtoggle;
                      });
                    }
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.white,
                    )
                ),
                labelText: 'Confirm Password',
                alignLabelWithHint: true,
                labelStyle:TextStyle(color: Colors.grey),
                floatingLabelStyle: TextStyle(color: Color(0xffdd3953)),
                // hintText: 'Enter Your Password'
              ),
            ),
          ),
          SizedBox(height: 50,),
          Center(
            child: SizedBox(
              height: 35,
              width: 150,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffdd3953),),
                  onPressed: () async{
                    final prefs = await SharedPreferences.getInstance();
                    var email1 = await prefs.getString('email');
                    String? email = email1;
                    String currentpassword = _currentpasswordController.text.trim();
                    String newpassword = _newpasswordController.text.trim();
                    var resp =await ApiService.changePassword(email: email, currentpassword: currentpassword,newpassword:newpassword);
                    if(resp == "Data"){
                      Fluttertoast.showToast(msg: 'Data saved successfully');
                    }
                    if(_currentpasswordController.text.trim().isEmpty){
                      {
                        showDialog(context: context, builder: (context) {
                          return SizedBox(
                            width: double.infinity,
                            height: 200,
                            // width : MediaQuery.of(context).size.width,
                            child: AlertDialog(
                              // contentPadding:EdgeInsets.zero,
                              // title: Text("Delete Account",style: TextStylolor: Colors.white),textAlign: TextAlign.center,),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(6.0))),
                              backgroundColor: Colors.black45,
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0,5,0,0),
                                    child: Text("Gay Dating App",style: TextStyle(color: Color(0xffdd3953),fontSize: 18)),
                                  ),
                                  SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                    child: Text('Please enter your current password',style: TextStyle(color: Colors.white,fontSize: 15),
                                        textAlign: TextAlign.left),
                                  ),
                                  SizedBox(height: 35,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                          onTap:(){
                                            Navigator.pop(context);
                                          },
                                          child: Text("OK",style: TextStyle(color: Color(0xffdd3953)),))
                                    ],
                                  )
                                ],),
                            ),
                          );
                        });
                      }
                    }
                    else if(_newpasswordController.text.trim().isEmpty){
                      {
                        showDialog(context: context, builder: (context) {
                          return SizedBox(
                            width: double.infinity,
                            height: 200,
                            // width : MediaQuery.of(context).size.width,
                            child: AlertDialog(
                              // contentPadding:EdgeInsets.zero,
                              // title: Text("Delete Account",style: TextStylolor: Colors.white),textAlign: TextAlign.center,),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(6.0))),
                              backgroundColor: Colors.black45,
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0,5,0,0),
                                    child: Text("Gay Dating App",style: TextStyle(color: Color(0xffdd3953),fontSize: 18)),
                                  ),
                                  SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                    child: Text('Please enter your new password',style: TextStyle(color: Colors.white,fontSize: 15),
                                        textAlign: TextAlign.left),
                                  ),
                                  SizedBox(height: 35,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                          onTap:(){
                                            Navigator.pop(context);
                                          },
                                          child: Text("OK",style: TextStyle(color: Color(0xffdd3953)),))
                                    ],
                                  )
                                ],),
                            ),
                          );
                        });
                      }
                    }
                    else if(_confirmpasswordController.text.trim().isEmpty){
                      {
                        showDialog(context: context, builder: (context) {
                          return SizedBox(
                            width: double.infinity,
                            height: 200,
                            // width : MediaQuery.of(context).size.width,
                            child: AlertDialog(
                              // contentPadding:EdgeInsets.zero,
                              // title: Text("Delete Account",style: TextStylolor: Colors.white),textAlign: TextAlign.center,),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(6.0))),
                              backgroundColor: Colors.black45,
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0,5,0,0),
                                    child: Text("Gay Dating App",style: TextStyle(color: Color(0xffdd3953),fontSize: 18)),
                                  ),
                                  SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                    child: Text('Please enter confirm password',style: TextStyle(color: Colors.white,fontSize: 15),
                                        textAlign: TextAlign.left),
                                  ),
                                  SizedBox(height: 35,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                          onTap:(){
                                            Navigator.pop(context);
                                          },
                                          child: Text("OK",style: TextStyle(color: Color(0xffdd3953)),))
                                    ],
                                  )
                                ],),
                            ),
                          );
                        });
                      }
                    }
                    else if(_confirmpasswordController.text.trim().isNotEmpty) {
                      if (_newpasswordController.text.trim() !=
                          _confirmpasswordController.text.trim()) {
                        {
                          {
                            showDialog(context: context, builder: (context) {
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
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5, 0, 0),
                                        child: Text("Gay Dating App",
                                            style: TextStyle(
                                                color: Color(0xffdd3953),
                                                fontSize: 18)),
                                      ),
                                      SizedBox(height: 10,),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        child: Text(
                                            'New Password and Confirm Password do not match',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                            textAlign: TextAlign.left),
                                      ),
                                      SizedBox(height: 35,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .end,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("OK",
                                                style: TextStyle(
                                                    color: Color(0xffdd3953)),))
                                        ],
                                      )
                                    ],),
                                ),
                              );
                            });
                          }
                        }
                      }
                    }
                  },
                  child: Text("Save")),
            ),
          ),
        ],
      ),
    );
  }
}
