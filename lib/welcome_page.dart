import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:gaydatingapp/signup_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:google_fonts/google_fonts.dart';

import 'people_page.dart';
import 'login_page.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {


  @override
  void initState() {
    super.initState();
    // GoogleFacebookSignout();
  }

 static String useremail = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            // colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.5), BlendMode.dstATop),
            image: AssetImage("assets/images/welcome-bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 140,
            ),
            SizedBox(
              height: 200,
            ),

            Container(
              width: 120.0,
              height: 120.0,
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
              padding: EdgeInsets.fromLTRB(30, 10 ,30, 5 ),
              child: SizedBox(
                height:45 ,
                width:double.infinity,
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
                      primary: Color(0xffff6b6b),),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/google.png',height: 20,width: 20,),
                        SizedBox(
                          width: 25,
                        ),
                        Text("CONNECT WITH GOOGLE",
                          style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
                      ],
                    )
                  // Text("Google",style: TextStyle(color: Colors.black,fontSize: 20),)
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 5 ,30, 10 ),
              child: SizedBox(
                height:50 ,
                width:double.infinity,
                child: ElevatedButton(
                    onPressed: () async{
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
                      primary: Color(0xff3a559f),),
                    child:Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/fb.png',height: 20,width: 20,),
                        SizedBox(
                          width: 25,
                        ),
                        Text("CONNECT WITH FACEBOOK",
                          style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
                      ],
                    )
                  // Text("Google",style: TextStyle(color: Colors.black,fontSize: 20),)
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(children: <Widget>[
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 30.0, right: 15.0),
                    child: Divider(
                      color: Colors.grey,
                      height: 10,
                    )),
              ),

              Text("Or",style:TextStyle(color: Colors.white,fontSize: 15)),

              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 15.0, right: 30.0),
                    child: Divider(
                      color: Colors.grey,
                      height: 10,
                    )),
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: SizedBox(
                    height: 50,
                    width:145,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xffdd3953),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                        )
                        ),
                        onPressed: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight:FontWeight.w600),)),
                  ),
                ),
               SizedBox(
                 width:15,
               ),
                Flexible(
                  child: SizedBox(
                    height: 50,
                    width:145,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(width: 1.0,color: Color(0xffdd3953)),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                          primary: Colors.black,),
                        onPressed: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SignupPage(),
                            ),
                          );
                        },
                        child: Text("Sign Up",style: TextStyle(color: Color(0xffdd3953),fontSize: 16,fontWeight: FontWeight.w600),)),
                  ),
                ),
              ],
            ),
          ],
        )
      ),
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

    useremail = googleUser!.email;
    String? name=googleUser!.displayName;
    var userid=googleUser!.id;
    print(useremail);
    print(name);
    print(userid);
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
      permissions: ['name','email','user_birthday', 'user_gender',],
    );

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
    FacebookAuthProvider.credential(loginResult.accessToken!.token);

    if (loginResult.status == LoginStatus.success) {
      print("Working");
      final userData = await FacebookAuth.instance.getUserData(
        fields: "name,email,birthday,gender,",
      );
      print(userData["name"]);
      print(userData["email"]);

    }else{
      print("not working");
    }

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  Future<void> signOut() async {
    await FacebookAuth.instance.logOut();
    // await FirebaseAuth.instance.signOut();
  }

  void GoogleFacebookSignout() async{
    await FirebaseAuth.instance.signOut();
    useremail = "";
    await GoogleSignIn().signOut();
    signOut();
  }
}
