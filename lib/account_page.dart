import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gaydatingapp/DBHelper.dart';
import 'package:gaydatingapp/password_page.dart';
import 'package:gaydatingapp/phone_page.dart';
import 'package:gaydatingapp/login_page.dart';
import 'package:gaydatingapp/welcome_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';
import 'blocked_users_page.dart';
import 'edit_info.dart';

class Account_Page extends StatefulWidget {
  const Account_Page({Key? key}) : super(key: key);

  @override
  State<Account_Page> createState() => _Account_PageState();
}

class _Account_PageState extends State<Account_Page> {

  late SharedPreferences prefs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff35132b),
      appBar: AppBar(
        titleSpacing: 0,
        leadingWidth: 33,
        centerTitle: false,
        title:Text("Account",style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xff35132b),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              //     // highlightColor: Colors.black,
            ),
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditInfoPage(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/images/ic_edit_pro.png",height: 35,width: 35,),
                        // SizedBox(
                        //   width: 12,
                        // ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.025,
                        ),
                        Text("Edit Profile",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    // SizedBox(width: 150,),
                    Icon(Icons.arrow_forward_ios,size: 30,color: Colors.grey,)
                  ],
                ),
              ),
            ),
          ),
          Divider(color: Colors.grey.withOpacity(0.2),height: 0,),
          Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              //     // highlightColor: Colors.black,
            ),
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PhonePage(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/images/ic_phone.png",height: 35,width: 35,),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.025,
                        ),
                        Text("Phone",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios,size: 30,color: Colors.grey,)
                  ],
                ),
              ),
            ),
          ),
          Divider(color: Colors.grey.withOpacity(0.2),height: 0,),
          Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              //     // highlightColor: Colors.black,
            ),
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PasswordPage(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/images/ic-pswd.png",height: 35,width: 35,),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.025,
                        ),
                        Text("Password",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios,size: 30,color: Colors.grey,)
                  ],
                ),
              ),
            ),
          ),
          Divider(color: Colors.grey.withOpacity(0.2),height: 0,),
          Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              //     // highlightColor: Colors.black,
            ),
            child: InkWell(
              onTap:  () {
                showDialog(context: context, builder: (context) {
                  return SizedBox(
                     width: double.infinity,
                   // width : MediaQuery.of(context).size.width,
                  child: AlertDialog(
                      contentPadding:EdgeInsets.zero,
                      // title: Text("Delete Account",style: TextStylolor: Colors.white),textAlign: TextAlign.center,),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0))),
                      backgroundColor: Colors.black,
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,5,0,0),
                            child: Text("Delete Account",style: TextStyle(color: Colors.white,fontSize: 18)),
                          ),
                          SizedBox(height: 25,),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15,0,15,0),
                            child: Text('Are you sure you want to delete your account? This will permanently erase your account.',style: TextStyle(color: Colors.white,fontSize: 15),
                                textAlign: TextAlign.center),
                          ),
                          SizedBox(height: 10,),
                          Divider(color: Colors.grey.withOpacity(0.2),height: 0,),
                          IntrinsicHeight(
                              child: Row(
                            //     crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(child: InkWell(
                                onTap:(){
                          Navigator.pop(context);
                          },
                                child: Container(
                                  alignment: Alignment.center,
                                  height:  35,
                                  child: Text("Cancel",style: TextStyle(color: Colors.blue),textAlign: TextAlign.center,),
                                ),
                              )),
                              VerticalDivider(
                                thickness: 1,
                                color: Colors.grey.withOpacity(0.2),
                              ),

                              Expanded(child: InkWell(
                                onTap:() async {
    final prefs = await SharedPreferences.getInstance();
    var email = await prefs.getString('email');
    if(email != '' || email != null) {
      print("working");
      var resp = await ApiService.delAccount(email: email);
      Navigator.pop(context);
      Fluttertoast.showToast(msg: resp["Delete User"]["message"]);
      await prefs.remove('gender');
      await prefs.remove('email');
      await prefs.remove('dob');
      await prefs.remove('name');
      await prefs.remove('email');
      await prefs.remove('password');
      await prefs.remove('confirmpassword');
      Navigator.pop(context);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => WelcomeScreen(),
        ),
      );
    }

                  },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 35,
                                  child: Text("Delete",style: TextStyle(color: Colors.red),textAlign: TextAlign.center),
                                ),
                              )),
                            ],
                          ))

                        ],),
                    ),
                  );
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/images/ic_deactive.png",height: 35,width: 35,),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.025,
                        ),
                        Text("Deactivate",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    // SizedBox(width: 152,),
                    Icon(Icons.arrow_forward_ios,size: 30,color: Colors.grey,)
                  ],
                ),
              ),
            ),
          ),
          Divider(color: Colors.grey.withOpacity(0.2),height: 0,),
          Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              //     // highlightColor: Colors.black,
            ),
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Blocked_UsersPage(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/images/ic_blockuser.png",height: 35,width: 35,),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.025,
                        ),
                        Text("Blocked Users",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios,size: 30,color: Colors.grey,)
                  ],
                ),
              ),
            ),
          ),
          Divider(color: Colors.grey.withOpacity(0.2),height: 0,),
          Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              //     // highlightColor: Colors.black,
            ),
            child: InkWell(
              onTap:  () {
                showDialog(context: context, builder: (context) {
                  return SizedBox(
                    width: double.infinity,
                    // width : MediaQuery.of(context).size.width,
                    child: AlertDialog(
                      contentPadding:EdgeInsets.zero,
                      // title: Text("Delete Account",style: TextStylolor: Colors.white),textAlign: TextAlign.center,),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0))),
                      backgroundColor: Colors.black,
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,5,0,0),
                            child: Text("Logout",style: TextStyle(color: Colors.white,fontSize: 18)),
                          ),
                          SizedBox(height: 25,),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15,0,15,0),
                            child: Text('Are you sure you want to log out?',style: TextStyle(color: Colors.white,fontSize: 15),
                                textAlign: TextAlign.center),
                          ),
                          SizedBox(height: 10,),
                          Divider(color: Colors.grey.withOpacity(0.2),height: 0,),
                          IntrinsicHeight(
                              child: Row(
                                //     crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(child: InkWell(
                                    onTap:(){
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 35,
                                      child: Text("Cancel",style: TextStyle(color: Colors.blue),textAlign: TextAlign.center,),
                                    ),
                                  )),
                                  VerticalDivider(
                                    thickness: 1,
                                    color: Colors.grey.withOpacity(0.2),
                                  ),

                                  Expanded(child: InkWell(
                                    onTap:()async {
                                      GoogleFacebookSignout();
                                      final prefs = await SharedPreferences.getInstance();
                                      await prefs.remove('gender');
                                      await prefs.remove('email');
                                      await prefs.remove('dob');
                                      await prefs.remove('name');
                                      await prefs.remove('email');
                                      await prefs.remove('password');
                                      await prefs.remove('confirmpassword');
                                      Navigator.pop(context);
                                      Fluttertoast.showToast(msg: "Loggedout Successfully");
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => WelcomeScreen(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 35,
                                      child: Text("Logout",style: TextStyle(color: Colors.red),textAlign: TextAlign.center),
                                    ),
                                  )),
                                ],
                              ))

                        ],),
                    ),
                  );
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/images/ic_logout.png",height: 35,width: 35,),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.025,
                        ),
                        Text("Logout",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios,size: 30,color: Colors.grey,)
                  ],
                ),
              ),
            ),
          ),
          Divider(color: Colors.grey.withOpacity(0.2),height: 0,),



        ],
      ),
    );
  }
  Future<void> signOut() async {
    await FacebookAuth.instance.logOut();
    // await FirebaseAuth.instance.signOut();
  }

  void GoogleFacebookSignout() async{
    await FirebaseAuth.instance.signOut();
    WelcomeScreenState.useremail = "";
    await GoogleSignIn().signOut();
    signOut();
  }
}
