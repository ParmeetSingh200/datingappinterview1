
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
import 'forgot_password.dart';
import 'model/login_model.dart';
import 'model/signup_model.dart';
import 'people_page.dart';
// import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
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

class _LoginPageState extends State<LoginPage> {

  late bool toggle = true;

  String? useremail='';
  String? name='';
  String? userid='';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // late final SharedPreferences prefs;
  // late bool newuser;
  // late String? user;

   Future<String?> _getData(String email,String psswd) async {
   LoginModel  loginmodel = (await ApiService.postUserslogin(email, psswd))!;
     // Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));


   if(loginmodel.login?.error==false)
   {
     Navigator.of(context).pushReplacement(
       MaterialPageRoute(
         builder: (context) => InboxPage(),
       ),
     );
   }
   else{
     // ScaffoldMessenger.of(context).showSnackBar(
     //   SnackBar(
     //     content: Text("Login error"),
     //   ),
     // );
     return "error";
   }
   }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     check_if_already_login();
  }

  check_if_already_login() async{
    // prefs = await SharedPreferences.getInstance();
    // DbHelper.deleteData(key: "email");
    final prefs = await SharedPreferences.getInstance();
    // final success = await prefs.remove('email');
    // print(success);

    // final String? action = await prefs.getString('email');
    var email = await prefs.getString('email');
    var gender = await prefs.getString('gender');
    print(email);
    print(gender);

    if(email!=null){
      try {
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
        }
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
        // actions: [
        //   IconButton(onPressed: ()async {
        //     print("Logged out");
        //     final prefs = await SharedPreferences.getInstance();
        //     await prefs.remove('gender');
        //     await prefs.remove('email');
        //     await prefs.remove('dob');
        //     await prefs.remove('name');
        //     await prefs.remove('email');
        //     await prefs.remove('password');
        //     await prefs.remove('confirmpassword');
        //   },
        //     icon: new Icon(Icons.arrow_back),)
        // ],
        title: Text("Login",style:TextStyle(color: Colors.white,fontSize: 18,)),
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
                height: 140,
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
                height: 50,
              ),
          Padding(
            padding: EdgeInsets.fromLTRB(25, 5 ,25, 5),
            child: TextField(
                textInputAction: TextInputAction.next,
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
            height: 31,
          ),
            Padding(
              padding: EdgeInsets.fromLTRB(25, 0 ,25, 5),
              child: TextField (
                style: TextStyle(color: Colors.white),
                controller: _passwordController,
                obscureText:toggle,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                fillColor: Colors.transparent,
                // suffixIcon: Image.asset('assets/images/ic-eye-disable.png',height: 10,width: 10,),
                suffixIcon: IconButton(
                    color: Color(0xffdd3953),
                    icon: Icon(
                      toggle ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        toggle = !toggle;
                      });
                    }

                  // color: Color(0xffdd3953),
                ),
                // suffixIconConstraints: BoxConstraints(
                //   minHeight: 20,
                //   minWidth: 20,
                // ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.white,
                      )
                  ),
                  labelText: 'Password',
                labelStyle:TextStyle(color: Colors.grey),
                alignLabelWithHint: true,
                floatingLabelStyle: TextStyle(color: Color(0xffdd3953)),
              // hintText: 'Enter Your Password'
      ),
    ),
            ),
              SizedBox(
                height: 60,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25, 0 ,25, 5),
                child: SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffdd3953),),
                      onPressed: () async{

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
                        else if(_passwordController.text.trim().isEmpty){
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
                                        child: Text('Please enter your password',style: TextStyle(color: Colors.white,fontSize: 15),
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
    });
    }
    else{
    print("Pressed");
    String email=_emailController.text.trim();
    String password=_passwordController.text.trim();
    // loginmodel =  ApiService.postUserslogin(username,password);
    var res =await _getData(email,password);
    print("error");
    if(_emailController.text.trim() != "" && _passwordController.text.trim() != "") {
    // await  prefs.setBool('login', false);
    if(res!="error") {
    print("no error");
    Fluttertoast.showToast(msg: "Loggedin successfully");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    }
    else{
    Fluttertoast.showToast(msg: "Invalid parameters or Invalid credentials");
    }
    }
    }
                        }
                      },
                      child: Text("Login")),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ForgotPasswordPage(),
                    ),
                  );
                },
                  child: Text("Forgot Password?",style: TextStyle(color: Colors.white),)),
              SizedBox(
                height: 30,
              ),
          Row(children: <Widget>[
            Expanded(
              child: new Container(
                  margin: const EdgeInsets.only(left: 25.0, right: 15.0),
                  child: Divider(
                    color: Colors.grey,
                    height: 10,
                  )),
            ),

            Text("OR",style: TextStyle(color: Colors.grey),),

            Expanded(
              child: new Container(
                  margin: const EdgeInsets.only(left: 15.0, right: 25.0),
                  child: Divider(
                    color: Colors.grey,
                    height: 10,
                  )),
            ),
          ]),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25, 0 ,10, 10 ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Continue with",
                    style: TextStyle(color: Colors.white),),
                ),
              ),
SizedBox(height: 13,),
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Flexible(
      child: SizedBox(
          height:37 ,
          width:140 ,
          child: ElevatedButton(
              onPressed: () async {
                try {
                  signInWithGoogle(context);

                  // Navigator.of(context).pushReplacement(
                  //   MaterialPageRoute(
                  //     builder: (context) => InboxPage(),
                  //   ),
                  // );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString()),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffff6b6b),),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/images/google.png',height: 16,width: 16,),
                  Text("GOOGLE",
                    style: TextStyle(color: Colors.white,fontSize: 15),),
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
           width:150 ,
          child: ElevatedButton(
              onPressed: () async{
                try {
                  await signInWithFacebook();

                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString()),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff3a559f),),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  Image.asset('assets/images/fb.png',height: 20,width: 20,),
                  // SizedBox(
                  //   width: 25,
                  // ),
                  Text("FACEBOOK",
                    style: TextStyle(color: Colors.white,fontSize: 15,),),
                ],
              )
            // Text("Google",style: TextStyle(color: Colors.black,fontSize: 20),)
          ),
      ),
    )

  ],
),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10 ,18, 20 ),
                child: Text("Gay App NEVER post anything to your social channels",style: TextStyle(color: Colors.grey,fontStyle: FontStyle.italic),textAlign: TextAlign.center,),
              ),

            ],

          ),
        ),
      ),
      )
//       Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           // mainAxisSize: MainAxisSize.max,
//
//           // mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//               decoration:  BoxDecoration(
//                 // border: Border.all(width: 0, color: Colors.black)
//               ),
//               child: Text("LOG IN",textAlign: TextAlign.center,style:TextStyle(color: Color(0xffff6b6b),fontSize: 20),),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//         Padding(
//           padding: EdgeInsets.fromLTRB(10, 5 ,10, 5),
//           child: TextField (
//             decoration: InputDecoration(
//               enabledBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(
//                   width: 1,
//                   color: Colors.grey,
//                 )
//               ),
//                 labelText: 'Email',
//                 hintText: 'Enter Your Email'
//             ),
//           ),
//         ),
//         // SizedBox(
//         //   height: 0,
//         // ),
//           Padding(
//             padding: EdgeInsets.fromLTRB(10, 0 ,10, 5),
//             child: TextField (
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
//             hintText: 'Enter Your Password'
//       ),
//     ),
//           ),
//             SizedBox(
//               height: 25,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: SizedBox(
//                 height: 45,
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       primary: Color(0xffff6b6b),),
//                     onPressed: (){},
//                     child: Text("LOGIN")),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Text("Forgot Password?",style: TextStyle(color: Colors.grey),),
//             SizedBox(
//               height: 20,
//             ),
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
//             SizedBox(
//               height: 20,
//             ),
//             Padding(
//               padding: EdgeInsets.fromLTRB(10, 0 ,10, 10 ),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text("Continue with",
//                   style: TextStyle(color: Colors.black),),
//               ),
//             ),
// Row(
//   children: [
//     Padding(
//       padding: EdgeInsets.fromLTRB(40, 10 ,10, 10 ),
//       child: SizedBox(
//         height:40 ,
//         width:120 ,
//         child: ElevatedButton(
//             onPressed: (){},
//             style: ElevatedButton.styleFrom(
//               primary: Colors.grey,),
//             child:Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Image.asset('assets/google-logo.png',height: 20,width: 20,),
//                 Text("GOOGLE",
//                   style: TextStyle(color: Colors.black,fontSize: 15),),
//               ],
//             )
//             // Text("Google",style: TextStyle(color: Colors.black,fontSize: 20),)
//         ),
//       ),
//     ),
//     Padding(
//       padding: EdgeInsets.fromLTRB(15, 10 ,10, 10 ),
//       child: SizedBox(
//         height:40 ,
//         width:130 ,
//         child: ElevatedButton(
//             onPressed: (){},
//             style: ElevatedButton.styleFrom(
//               primary: Color(0xff3a559f),),
//             child:Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//
//                 Text("f", style: TextStyle(color: Colors.white,fontSize: 20),),
//                 Text("  FACEBOOK", style: TextStyle(color: Colors.black,fontSize: 15),),
//               ],
//             )
//           // Text("Google",style: TextStyle(color: Colors.black,fontSize: 20),)
//         ),
//       ),
//     )
//
//   ],
// ),
//             SizedBox(
//               height: 10,
//             ),
//             Text("Gay App Never post anything to your social channels",style: TextStyle(color: Colors.black),),
//
//           ],
//
//         ),
//       ),
    );

  }
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


    useremail = googleUser?.email;
     name=googleUser?.displayName;
    userid=googleUser?.id;

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
    final LoginResult loginResult = await FacebookAuth.instance.login(
        // permissions: ['email', 'user_gender',]
    );

    print("Loginworking");
    // if (loginResult.status == LoginStatus.success) {
    //   // print(loginResult.status);
    //   // print(loginResult.message);
    //
    //   print("Working");
    //   // final userData = await FacebookAuth.instance.getUserData(fields: "email,gender,",);
    //   // var name=userData["name"];
    //   // print(name);
    // }
    // else{
    //   print("not working");
    // }
    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
    FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
