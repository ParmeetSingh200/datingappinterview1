
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:gaydatingapp/DBHelper.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_service.dart';
import 'login_page.dart';
import 'model/login_model.dart';
import 'model/signup_model.dart';
import 'people_page.dart';
// import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

String validateEmail(String value) {
  Pattern pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  // Pattern pattern1=r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]";
  RegExp regex = new RegExp(pattern.toString());
  if (!regex.hasMatch(value) && regex !=null)
    return 'EnterValid';
  else{
    return "lost";
  };
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  late bool toggle = true;

  String? useremail='';
  String? name='';
  String? userid='';

  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset : false,
        // backgroundColor:Colors.white,
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
          title: Text("Forgot Password",style:TextStyle(color: Colors.white,fontSize: 18,)),
          backgroundColor:Colors.transparent,
          centerTitle: true,
          // elevation:0,
        ),
        body: Container(
          // height: MediaQuery.of(context).size.height,
          // width: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              // colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.5), BlendMode.dstATop),
              image: AssetImage("assets/images/login-bkgrd.png"),
              fit: BoxFit.cover,
            ),
          ),
          child:Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisSize: MainAxisSize.max,

                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 140.0,
                    height: 140.0,
                    decoration: new BoxDecoration(
                        border: Border.all(
                          // color: Color.fromARGB(255, 156, 20, 20),
                          width: 1,
                        ),
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/logo-white.png'),
                        )),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 5 ,25, 5),
                    child: Text("We need to confirm your email to send you instructions to reset your password.",style: TextStyle(color: Colors.white,),textAlign: TextAlign.center,),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 5 ,25, 5),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,14,0),
                          child: Image.asset('assets/images/message.png',height: 20,width: 20,),
                        ),
                        suffixIconConstraints: BoxConstraints(
                          minHeight: 20,
                          minWidth: 20,
                        ),
                        //   suffixIcon: ImageIcon(
                        //   AssetImage("assets/images/message.png",),
                        //     size: 1,
                        // ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.white,
                            )
                        ),
                        labelText: 'Email',
                        labelStyle:TextStyle(color: Colors.grey),
                        alignLabelWithHint: true,
                        floatingLabelStyle: TextStyle(color: Color(0xffdd3953)),
                        // hintText: 'Enter Your Email'
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 0 ,25, 5),
                    child: SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xffdd3953),),
                          onPressed: () async{
                            print("Pressed");
                            String email=_emailController.text.trim();
                            if(_emailController.text.trim().isEmpty){
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
                                            child: Text('Please enter your email address',style: TextStyle(color: Colors.white,fontSize: 15),
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
                            else if(_emailController.text.trim().isNotEmpty || _emailController.text.trim()==null )
                            {
                              String val= validateEmail(_emailController.text.trim());
                              if(val=='EnterValid'){
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
                                            child: Text('Please enter valid email',style: TextStyle(color: Colors.white,fontSize: 15),
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
                                }

                                );
                              }
                              else{
                                var resp =await ApiService.forgotPassword(email: email);
                                Fluttertoast.showToast(
                                    msg: resp["Forgot Password"]["message"]);
                                if(resp["Forgot Password"]["error"] == false) {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  );
                                }
                              }
                            }
                          },
                          child: Text("Send")),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],

              ),
            ),
          ),
        )
    );
  }
}
