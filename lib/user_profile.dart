
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaydatingapp/preferance.dart';
import 'package:gaydatingapp/privacypolicy_page.dart';
import 'package:gaydatingapp/terms&conds_page.dart';
import 'package:image_picker/image_picker.dart';

import 'account_page.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  final ImagePicker _picker = ImagePicker();
  var imageFile="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff35132b),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Profile"),elevation: 0,
        backgroundColor: Color(0xff35132b),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Center(
            child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height:  150,
                    width: 150,
                    decoration:  BoxDecoration(
                        border: Border.all(width: 1, color: Color(0xffff6b6b),),
                      borderRadius: BorderRadius.circular(4), // Image border
                    ),
                    // child: Image.asset("assets/images/dummy-user-six.jpg",height: 20,width: 20,
                    //   fit: BoxFit.fill,
                    // ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4), // Image border
                      child: SizedBox.fromSize(
                          size: Size.fromRadius(48), // Image radius
                        child:Column(

                          children: [
                            imageFile.isEmpty ?
                            Expanded(child: Image.asset("assets/images/user_placeholder.jpg",fit: BoxFit.fill))

                                : Expanded(child: Image.file((File(imageFile,)),width:double.infinity,fit: BoxFit.cover,)),
                          ],

                        )
                        // imageFile == null ?
                        //  Image.asset("assets/images/user_placeholder.jpg",height: 20,width: 20,fit: BoxFit.fill)
                        //      : FileImage(File(imageFile)),

                    ),
                  ),
                  ),
                  // Positioned(
                  //   top: -9, right: -9, //give the values according to your requirement
                  //   child:CircleAvatar(radius: 10,
                  //     backgroundColor: Colors.white,),
                  // ),
                  Positioned(
                    bottom: -9, right: -11, //give the values according to your requirement
                    child: InkWell(
                      onTap: (){
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
                              backgroundColor: Colors.black,
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5,),
                                  Text("Select image source",style: TextStyle(color: Colors.white,fontSize: 18)),
                                  SizedBox(height: 20,),
                                  InkWell(
                                    onTap: () async{
                                      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                                      if(photo != null) {
                                        setState((){
                                          imageFile = photo.path;
                                        });
                                      }
                                      Navigator.pop(context);
                                    },

                                    child: Text('Take a picture',style: TextStyle(color: Colors.white,fontSize: 16),
                                        textAlign: TextAlign.left),
                                  ),
                                  SizedBox(height: 30 ,),
                                  InkWell(
                                    onTap: () async{
                                      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                                      if(image != null) {
                                        setState((){
                                          imageFile = image.path;
                                        });
                                      }
                                      print(imageFile);
                                      Navigator.pop(context);
                                    },
                                    child: Text('Choose from gallery',style: TextStyle(color: Colors.white,fontSize: 16),
                                        textAlign: TextAlign.left),
                                  ),
                                ],),
                            ),
                          );
                        });
                      },
                      child: CircleAvatar(
                        radius: 16.0,
                        child: ClipRRect(
                          child: Image.asset("assets/images/profile-edit.png"),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                  ),
                ]
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text("Avinash",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
          SizedBox(
            height: 30,
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
                    builder: (context) => Preference_Page(),
                  ),
                );
              },
              child: Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 22,horizontal: 16),
                    child:
                    Image.asset("assets/images/ic-preference.png",height: 35,width: 35,)
                  ),
                  Text("Preferences",style: TextStyle(color: Colors.white,fontSize: 17),),
                ],
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
                    builder: (context) => Account_Page(),
                  ),
                );
              },
              child:
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 22,horizontal: 16),
                      child:
                      Image.asset("assets/images/ic_setting.png",height: 35,width: 35,)
                  ),
                  Text("Account",style: TextStyle(color: Colors.white,fontSize: 17),),
                ],
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
                    builder: (context) => TermsandConditionsPage(),
                  ),
                );
              },
              child: Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 22,horizontal: 16),
                      child:
                      Image.asset("assets/images/ic_help.png",height: 35,width: 35,)
                  ),
                  Text("Terms & Conditions",style: TextStyle(color: Colors.white,fontSize: 17),),
                ],
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
                      builder: (context) => PrivacypolicyPage(),
                    ),
                  );
                },
              child: Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 22,horizontal: 16),
                      child:
                      Image.asset("assets/images/ic_privacy.png",height: 35,width: 35,)
                  ),
                  Text("Privacy Policy",style: TextStyle(color: Colors.white,fontSize: 17),),
                ],
              ),
            ),
          ),
          Divider(color: Colors.grey.withOpacity(0.2),height: 0,),

        ],
      ),
    );
  }
}
