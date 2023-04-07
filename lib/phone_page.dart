import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

class PhonePage extends StatefulWidget {
  const PhonePage({Key? key}) : super(key: key);

  @override
  State<PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {

  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
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
        title: Text("Phone",style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xff35132b),
      ),
      body:Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(14, 0, 14, 5),
            child: TextField(
              controller: _phoneController,
              style: TextStyle(color: Colors.white),
              maxLength:10,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.grey,
                    )),
                labelText: 'Phone number',
                labelStyle: TextStyle(color: Colors.grey),
                alignLabelWithHint: true,
                floatingLabelStyle: TextStyle(color: Color(0xffdd3953)),
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
                    String phone = _phoneController.text.trim();
                    var resp =await ApiService.updatePhone(email: email, phonenumber: phone);
                    if(resp == "Data"){
                      Fluttertoast.showToast(msg: 'Data saved successfully');
                    }
                    if(_phoneController.text.trim().isEmpty){
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
                    child: Text('Please enter your phone number',style: TextStyle(color: Colors.white,fontSize: 15),
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
                  },
                  child: Text("Save")),
            ),
          ),
        ],
      ),
    );
  }
}
