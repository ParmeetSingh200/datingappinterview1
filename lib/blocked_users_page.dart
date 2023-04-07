import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Blocked_UsersPage extends StatefulWidget {
  const Blocked_UsersPage({Key? key}) : super(key: key);

  @override
  State<Blocked_UsersPage> createState() => _Blocked_UsersPageState();
}

class _Blocked_UsersPageState extends State<Blocked_UsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff35132b),
      appBar: AppBar(
        titleSpacing: 0,
        leadingWidth: 33,
        centerTitle: false,
        title:Text("Blocked Users",style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xff35132b),
      ),
      body: Center(
        child: Text("No data Found",style: TextStyle(color: Colors.white,fontSize:16,fontWeight: FontWeight.bold),
      ),
    ),
    );
  }
}
