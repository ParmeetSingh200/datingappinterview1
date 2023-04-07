import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrivacypolicyPage extends StatefulWidget {
  const PrivacypolicyPage({Key? key}) : super(key: key);

  @override
  State<PrivacypolicyPage> createState() => _PrivacypolicyPageState();
}

class _PrivacypolicyPageState extends State<PrivacypolicyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        titleSpacing: 0,
        leadingWidth: 33,
        centerTitle: false,
        title:Text("Privacy Policy",style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xff35132b),
      ),
    );
  }
}
