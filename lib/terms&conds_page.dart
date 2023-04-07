import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TermsandConditionsPage extends StatefulWidget {
  const TermsandConditionsPage({Key? key}) : super(key: key);

  @override
  State<TermsandConditionsPage> createState() => _TermsandConditionsPageState();
}

class _TermsandConditionsPageState extends State<TermsandConditionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        titleSpacing: 0,
        leadingWidth: 33,
        centerTitle: false,
        title:Text("Terms & Conditions",style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xff35132b),
      ),
    );
  }
}
