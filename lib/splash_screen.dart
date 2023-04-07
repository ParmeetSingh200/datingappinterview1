import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaydatingapp/welcome_page.dart';

class SplashScreen extends StatefulWidget {
const SplashScreen({Key? key}) : super(key: key);

  @override
    State<SplashScreen> createState() => _SplashScreenState();
  }

  class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WelcomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            // colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.5), BlendMode.dstATop),
            image: AssetImage("assets/images/splash-bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: 185.0,
              height: 185,
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
              height: 10,
            ),
            Text("One Hole",style: TextStyle(color: Color(0xfff9c1c6),fontSize: 26,fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}
