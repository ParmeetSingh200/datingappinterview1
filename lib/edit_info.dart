import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'account_page.dart';
import 'api_service.dart';

class EditInfoPage extends StatefulWidget {
  const EditInfoPage({Key? key}) : super(key: key);

  @override
  State<EditInfoPage> createState() => _EditInfoPageState();
}

class _EditInfoPageState extends State<EditInfoPage> {
  final ImagePicker _picker = ImagePicker();
  var imageFile="";

  bool dataLoaded=false;

  double value=0;

  bool toggle=false;

  String _currentSelectedGender = "";
  String _currentSelectedEthnicity = "";
  String _currentSelectedBodyType= "";
  String _currentSelectedPosition = "";
  String _currentSelectedRelStatus = "";

  final TextEditingController nameController= TextEditingController();
  final TextEditingController aboutController = TextEditingController();

  final FocusNode _ethnicityFocusNode = FocusNode();

  double _ageSliderValue = 18;
  double _heightSliderValue=100;
  double _weightSliderValue = 30;

  String startAgeText='18';
  String endValueAge='100';

  String startHeightText='100';
  String endValueHeight='300';

  String startWeightText='30';
  String endValueWeight='200';

  @override
  void initState(){
    GetProfile();
    value = 0;
    downloadData();
    super.initState();
  }

  Future<void> GetProfile() async {
            final prefs = await SharedPreferences.getInstance();
    var email = await prefs.getString('email');
    if(email != '' || email != null) {
      print("working");
        var resp = await ApiService.getProfile(email: email);
        // print((await resp["Get user"][0]["name"]));
        var name =await resp["Get user"][0]["name"].toString();
      var about =await resp["Get user"][0]["about"].toString();
        var gender =await resp["Get user"][0]["gender"].toString();
         var age =await resp["Get user"][0]["age"].toString();
        var height =await resp["Get user"][0]["height"].toString();
        if(height==''){
          height="100";
        }
        var weight =await resp["Get user"][0]["weight"].toString();
      if(weight==''){
        weight="30";
      }
      var ethnicity =await resp["Get user"][0]["ethnicity"].toString();
      var body_type =await resp["Get user"][0]["body_type"].toString();
      var position =await resp["Get user"][0]["position"].toString();
      var relationship_status =await resp["Get user"][0]["relationship_status"].toString();

      setState(() {
        _ageSliderValue=double.parse(age);
        startAgeText= age!;
        nameController.text = name!;
        aboutController.text=about!;
        _currentSelectedGender = gender;
         _heightSliderValue=double.parse(height);
        startHeightText = height;
        _weightSliderValue=double.parse(weight);
        startWeightText = weight;
        _currentSelectedEthnicity = ethnicity;
        _currentSelectedBodyType = body_type;
        _currentSelectedPosition = position;
        _currentSelectedRelStatus = relationship_status;
        dataLoaded=true;
        value=1;
      });
    }
  }

  void downloadData(){
    new Timer.periodic(
        Duration(seconds: 2),
            (Timer timer){
          setState(() {
            if(value == 1) {
              timer.cancel();
            }
            else {
              value = value + 0.1;
            }
          });
        }
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    aboutController.dispose();
    _ethnicityFocusNode.dispose();
    super.dispose();
  }

  var _currenciesGender = [
    "Male",
  ];
  var _currenciesEthnicity = [
    "Black or African American",
    "Asian",
    "White",
    "American Indian or Alaska Native",
  ];
  var _currenciesBodyType = [
    "Big boned with a sturdy frame",
    "Athletic build",
    "Well defined muscles",
    "Rectangular shaped body",
    "Generally strong",
    "Hourglass",
    "Diamond",
    "Round or oval",
  ];
  var _currenciesPosition = [
    "Top",
    "Bottom",
    "Versatile",
  ];

  var _currenciesRelStatus = [
    "Single",
    "Married",
    "Divorced",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff35132b),
      appBar: AppBar(
        titleSpacing: 0,
        leadingWidth: 33,
        centerTitle: false,
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: (){
            if (FocusScope.of(context).isFirstFocus) {
              FocusScope.of(context).unfocus();
            }
            Navigator.of(context).pop (
            );
          },

        ),
        backgroundColor: Color(0xff35132b),
      ),
      body:
      dataLoaded ?
      SingleChildScrollView(
             child:
             Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                     SizedBox(
                       height: 20,
                     ),
                     Row(
                       children: [
                         SizedBox(
                           width: 20,
                         ),
                         // Stack(
                         //   clipBehavior: Clip.none,
                         //   children: [
                         //   Container(
                         //     height: 100,
                         //     width: 100,
                         //     decoration:  BoxDecoration(
                         //         border: Border.all(width: 1, color: Color(0xffff6b6b),
                         //         ),Zz
                         //       borderRadius:BorderRadius.circular(3)
                         //     ),
                         //     child: Image.asset("assets/images/dummy-user-six.jpg",height: 20,width: 20,
                         //       fit: BoxFit.fill,
                         //     ),
                         //   ),
                         //     Positioned(
                         //       top: -9, right: -9, //give the values according to your requirement
                         //       child:CircleAvatar(radius: 10,
                         //       backgroundColor: Colors.white,),
                         //     ),
                         //     Positioned(
                         //       top: -9, right: -9, //give the values according to your requirement
                         //       child:Icon(Icons.cancel,color:Color(0xffff6b6b),),
                         //     ),
                         //   ]
                         // ),
                          imageFile.isEmpty ?
                         Container(
                           height: 100,
                             width: 100,
                             decoration:  BoxDecoration(
                                border: Border.all(width: 1, color: Colors.white),
                                 borderRadius:BorderRadius.circular(6)
                             ),
                           child:
                           Column(
                             children: [
                               SizedBox(
                                 height: 20,
                               ),
                               InkWell(
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
                                                 final prefs = await SharedPreferences.getInstance();
                                                 var email1 = await prefs.getString('email');
                                                 print(email1);
                                                 String? email = email1;
                                                 Navigator.pop(context);
                                                 var resp =await ApiService.updateImage(email: email, image: imageFile);

                                                 if(resp == "Data"){
                                                   print("Data");
                                                   // Fluttertoast.showToast(msg: 'Data saved successfully');
                                                 }
                                                 else{
                                                   print("error");
                                                 }
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
                                                 final prefs = await SharedPreferences.getInstance();
                                                 var email1 = await prefs.getString('email');
                                                 // print(email1);
                                                 String? email = email1;
                                                 Navigator.pop(context);
                                                 var resp =await ApiService.updateImage(email: email, image: imageFile);
                                                 if(resp == "Data"){
                                                   print("Data");
                                                   Fluttertoast.showToast(msg: 'Data saved successfully');
                                                 }
                                                 else {
                                                   print("error");
                                                 }
                                               },
                                               child: Text('Choose from gallery',style: TextStyle(color: Colors.white,fontSize: 16),
                                                   textAlign: TextAlign.left),
                                             ),
                                           ],),
                                       ),
                                     );
                                   });
                                 },
                                   child: Icon(Icons.add_circle_outlined,color:Colors.white,)),
                               SizedBox(
                                 height: 10,
                               ),
                               Text("Add Image",style: TextStyle(color: Colors.white),),
                             ],
                           )
                           //      Stack(
                           //       children: [ClipRRect(
                           //   borderRadius: BorderRadius.circular(4), // Image border
                           //   child: SizedBox.fromSize(
                           //         size: Size.fromRadius(48), // Image radius
                           //         child:Column(
                           //           children: [
                           //              Expanded(child: Image.file((File(imageFile,)),width:double.infinity,fit: BoxFit.cover,)),
                           //
                           //           ],
                           //
                           //         )
                           //       // imageFile == null ?
                           //       //  Image.asset("assets/images/user_placeholder.jpg",height: 20,width: 20,fit: BoxFit.fill)
                           //       //      : FileImage(File(imageFile)),
                           //
                           //   ),
                           // ),
                           //   ]
                           //     ),
                         )
                         :  Stack(
                            clipBehavior: Clip.none,
                           children: [
                             Container(
                               height: 100,
                               width: 100,
                               decoration:  BoxDecoration(
                                   border: Border.all(width: 1, color: Colors.white),
                                   borderRadius:BorderRadius.circular(6)
                               ),
                               child:
                                  ClipRRect(
                               borderRadius: BorderRadius.circular(4), // Image border
                               child: SizedBox.fromSize(
                                    size: Size.fromRadius(48), // Image radius
                                    child:Column(
                                      children: [
                                         Expanded(child: Image.file((File(imageFile,)),width:double.infinity,fit: BoxFit.cover,)),
                                      ],
                                    )
                                  // imageFile == null ?
                                  //  Image.asset("assets/images/user_placeholder.jpg",height: 20,width: 20,fit: BoxFit.fill)
                                  //      : FileImage(File(imageFile)),

                               ),
                             ),
                           ),
                             Positioned(
                                     top: -7, right: -7, //give the values according to your requirement
                                     child:CircleAvatar(radius: 10,
                                     backgroundColor: Colors.white,),
                                   ),
                                   Positioned(
                                     top: -9, right: -9, //give the values according to your requirement
                                     child:InkWell(
                                       onTap: (){
                                         setState(() {
                                           imageFile = '';
                                         });
                                       },
                                         child: Icon(Icons.cancel,color:Color(0xffff6b6b),)),
                                   ),
                           ]
                         )

                       ],
                     ),
                     Padding(
                       padding: EdgeInsets.fromLTRB(14, 18, 14, 5),
                       child: TextField(
                         style: TextStyle(color: Colors.white),
                         controller: nameController,
                         maxLength: 70,
                         keyboardType: TextInputType.text,
                         textCapitalization: TextCapitalization.words,
                         inputFormatters: [
                           FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]")),
                         ],
                         decoration: InputDecoration(
                           counterText: "",
                           contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                           enabledBorder: UnderlineInputBorder(
                               borderSide: BorderSide(
                                 width: 1,
                                 color: Colors.grey,
                               )),
                           labelText: 'Name',
                           labelStyle: TextStyle(color: Colors.grey),
                           alignLabelWithHint: true,
                           floatingLabelStyle: TextStyle(color: Color(0xffdd3953)),
                         ),
                       ),
                     ),
                     SizedBox(height: 12,),
                     Padding(
                       padding: EdgeInsets.fromLTRB(14, 0, 14, 5),
                       child: TextField(
                         inputFormatters: [
                           // UpperCaseTextFormatter(),
                         ],
                         controller: aboutController,
                         style: TextStyle(color: Colors.white),
                         decoration: InputDecoration(
                           contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                           enabledBorder: UnderlineInputBorder(
                               borderSide: BorderSide(
                                 width: 1,
                                 color: Colors.grey,
                               )),
                           labelText: 'About',
                           labelStyle: TextStyle(color: Colors.grey),
                           alignLabelWithHint: true,
                           floatingLabelStyle: TextStyle(color: Color(0xffdd3953)),
                         ),
                       ),
                     ),
                     SizedBox(height: 20,),
                     Padding(
                       padding: const EdgeInsets.fromLTRB(14,0,0,0),
                       child: Text("Age",style: TextStyle(color: Colors.grey),),
                     ),
                     // SizedBox(height: ,),
                     Slider(
                         divisions: 82,
                         activeColor: Color(0xffdd3953),
                         inactiveColor: Colors.grey,
                         min: 18,
                         max: 100,
                         value: _ageSliderValue,
                         label: _ageSliderValue.round().toString(),
                         onChanged: (value){
                           setState(() {
                             _ageSliderValue=value;
                             startAgeText=value.toStringAsFixed(0);
                           });
                         }
                     ),
                     Padding(
                       padding: const EdgeInsets.fromLTRB(14,0,14,0),
                       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text(startAgeText,style: TextStyle(color: Colors.white),),
                           Text(endValueAge,style: TextStyle(color: Colors.white)),
                         ],
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.fromLTRB(14,0,14,0),
                       child: ButtonTheme(
                         // alignedDropdown: true,
                         child: DropdownButtonFormField<String>(
                           icon: Icon(Icons.keyboard_arrow_down,color: Colors.white,),
                           dropdownColor: Colors.black,
                           decoration: InputDecoration(
                             contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                             enabledBorder: UnderlineInputBorder(
                               borderSide: BorderSide(
                                 width: 1,
                                 color: Colors.grey,
                               ),
                             ),
                             labelText: 'Gender',
                             labelStyle: TextStyle(color: Colors.grey),
                             alignLabelWithHint: true,
                             floatingLabelStyle: TextStyle(color: Color(0xffdd3953)),
                           ),
                           value: _currentSelectedGender.isNotEmpty
                               ? _currentSelectedGender
                               : null,
                           onChanged: (String? newValue) {
                             setState(() {
                               _currentSelectedGender = newValue!;
                               // state.didChange(newValue);
                             });
                           },
                           items: _currenciesGender.map((String value) {
                             return DropdownMenuItem<String>(
                               value: value,
                               child: Text(
                                 value,
                                 style: TextStyle(color: Colors.white),
                               ),
                             );
                           }).toList(),
                         ),
                       ),
                     ),
                     SizedBox(height: 25,),
                     Padding(
                       padding: const EdgeInsets.fromLTRB(14,0,0,0),
                       child: Text("Height(cm)",style: TextStyle(color: Colors.grey),),
                     ),
                     Slider(
                         divisions: 200,
                         activeColor: Color(0xffdd3953),
                         inactiveColor: Colors.grey,
                         min: 100,
                         max: 300,
                         value: _heightSliderValue,
                         label: _heightSliderValue.round().toString(),
                         onChanged: (value){
                           setState(() {
                             _heightSliderValue=value;
                             startHeightText=value.toStringAsFixed(0);
                           });
                         }
                     ),
                     Padding(
                       padding: const EdgeInsets.fromLTRB(14,0,14,0),
                       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text(startHeightText,style: TextStyle(color: Colors.white),),
                           Text(endValueHeight,style: TextStyle(color: Colors.white)),
                         ],
                       ),
                     ),
                     SizedBox(height: 25,),
                     Padding(
                       padding: const EdgeInsets.fromLTRB(14,0,0,0),
                       child: Text("Weight(Kg)",style: TextStyle(color: Colors.grey),),
                     ),
                     // SizedBox(height: ,),
                     Slider(
                         divisions: 170,
                         activeColor: Color(0xffdd3953),
                         inactiveColor: Colors.grey,
                         min: 30,
                         max: 200,
                         value: _weightSliderValue,
                         label: _weightSliderValue.round().toString(),
                         onChanged: (value){
                           // print("START: ${value.start}, End: ${value.end}");

                           setState(() {
                             _weightSliderValue=value;
                             startWeightText=value.toStringAsFixed(0);
                           });
                         }
                     ),
                     Padding(
                       padding: const EdgeInsets.fromLTRB(14,0,14,0),
                       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text(startWeightText,style: TextStyle(color: Colors.white),),
                           Text(endValueWeight,style: TextStyle(color: Colors.white)),
                         ],
                       ),
                     ),
                     SizedBox(height: 15,),
                   Padding(
                       padding: const EdgeInsets.fromLTRB(14,0,14,0),
                       child: ButtonTheme(
                         // alignedDropdown: true,
                         child: DropdownButtonFormField<String>(
                           focusNode: _ethnicityFocusNode,
                           autofocus: false,
                           icon: Icon(Icons.keyboard_arrow_down,color: Colors.white,),
                           dropdownColor: Colors.black,
                           // isExpanded: true,
                           // isDense: true,
                           decoration: InputDecoration(
                               contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                             enabledBorder: UnderlineInputBorder(
                               borderSide: BorderSide(
                                 width: 1,
                                 color: Colors.grey,
                               ),
                             ),
                             focusedBorder: UnderlineInputBorder(
                                 borderSide: BorderSide(color: Colors.grey)),
                             // prefixText: null,
                             labelText: 'Ethnicity',
                             labelStyle: TextStyle(color: Colors.grey),
                             alignLabelWithHint: true,
                             floatingLabelStyle: TextStyle(color: Colors.grey),
                           ),
                           value: _currentSelectedEthnicity.isNotEmpty
                               ? _currentSelectedEthnicity
                               : null,
                           onChanged: (String? newValue) {
                             setState(() {
                               _currentSelectedEthnicity = newValue!;
                               // state.didChange(newValue);
                             });
                           },
                           // selectedItemBuilder: (BuildContext context) {
                           //   return _currenciesEthnicity.map<Widget>((String item) {
                           //     return Container(
                           //          alignment: Alignment.centerLeft,
                           //         // width: 180,
                           //         child: Text(item,style: TextStyle(color: Colors.white), textAlign: TextAlign.end)
                           //     );
                           //   }).toList();
                           // },
                           items: _currenciesEthnicity.map((String value) {
                             return DropdownMenuItem<String>(
                                value: value,
                                 child: Text(
                                 value,textAlign: TextAlign.left,
                                 style: TextStyle(color: Colors.white,)
                               ),
                             );
                           }).toList(),
                         ),
                       ),
                     ),
                     SizedBox(height: 15,),
                     Padding(
                       padding: const EdgeInsets.fromLTRB(14,0,14,0),
                       child: ButtonTheme(
                         // alignedDropdown: true,
                         child: DropdownButtonFormField<String>(
                           // isExpanded: true,
                           // focusNode: _bodyt ypeFocusNode,
                           icon: Icon(Icons.keyboard_arrow_down,color: Colors.white,),
                           dropdownColor: Colors.black,
                           decoration: InputDecoration(
                             contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                             enabledBorder: UnderlineInputBorder(
                               borderSide: BorderSide(
                                 width: 1,
                                 color: Colors.grey,
                               ),
                             ),
                             focusedBorder: UnderlineInputBorder(
                                 borderSide: BorderSide(color: Colors.grey)),
                             labelText: 'Body Type',
                             labelStyle: TextStyle(color: Colors.grey),
                             alignLabelWithHint: true,
                             floatingLabelStyle: TextStyle(color: Colors.grey),
                           ),
                           value: _currentSelectedBodyType.isNotEmpty
                               ? _currentSelectedBodyType
                               : null,
                           onChanged: (String? newValue) {
                             setState(() {
                               _currentSelectedBodyType = newValue!;
                               // state.didChange(newValue);
                             });
                           },
                           items: _currenciesBodyType.map((String value) {
                             return DropdownMenuItem<String>(
                               value: value,
                               child: Text(
                                 value,
                                 style: TextStyle(color: Colors.white),
                               ),
                             );
                           }).toList(),
                         ),
                       ),
                     ),
                     SizedBox(height: 15,),
                     Padding(
                       padding: const EdgeInsets.fromLTRB(14,0,14,0),
                       child: ButtonTheme(
                         // alignedDropdown: true,
                         child: DropdownButtonFormField<String>(
                           // focusNode: _positionFocusNode,
                           icon: Icon(Icons.keyboard_arrow_down,color: Colors.white,),
                           dropdownColor: Colors.black,
                           decoration: InputDecoration(
                             contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                             enabledBorder: UnderlineInputBorder(
                               borderSide: BorderSide(
                                 width: 1,
                                 color: Colors.grey,
                               ),
                             ),
                             focusedBorder: UnderlineInputBorder(
                                 borderSide: BorderSide(color: Colors.grey)),
                             labelText: 'Position',
                             labelStyle: TextStyle(color: Colors.grey),
                             alignLabelWithHint: true,
                             floatingLabelStyle: TextStyle(color: Colors.grey),
                           ),
                           value: _currentSelectedPosition.isNotEmpty
                               ? _currentSelectedPosition
                               : null,
                           onChanged: (String? newValue) {
                             setState(() {
                               _currentSelectedPosition = newValue!;
                               // state.didChange(newValue);
                             });
                           },
                           items: _currenciesPosition.map((String value) {
                             return DropdownMenuItem<String>(
                               value: value,
                               child: Text(
                                 value,
                                 style: TextStyle(color: Colors.white),
                               ),
                             );
                           }).toList(),
                         ),
                       ),
                     ),
                     SizedBox(height: 15,),
                     Padding(
                       padding: const EdgeInsets.fromLTRB(14,0,14,0),
                       child: ButtonTheme(
                         // alignedDropdown: true,
                         child: DropdownButtonFormField<String>(
                           // focusNode: _relationshipFocusNode,
                           icon: Icon(Icons.keyboard_arrow_down,color: Colors.white,),
                           dropdownColor: Colors.black,
                           decoration: InputDecoration(
                             contentPadding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                             enabledBorder: UnderlineInputBorder(
                               borderSide: BorderSide(
                                 width: 1,
                                 color: Colors.grey,
                               ),
                             ),
                             focusedBorder: UnderlineInputBorder(
                                 borderSide: BorderSide(color: Colors.grey)),
                             labelText: 'Relationship Status',
                             labelStyle: TextStyle(color: Colors.grey),
                             alignLabelWithHint: true,
                             floatingLabelStyle: TextStyle(color: Colors.grey),
                           ),
                           value: _currentSelectedRelStatus.isNotEmpty
                               ? _currentSelectedRelStatus
                               : null,
                           onChanged: (String? newValue) {
                             setState(() {
                               _currentSelectedRelStatus = newValue!;
                               // state.didChange(newValue);
                             });
                           },
                           items: _currenciesRelStatus.map((String value) {
                             return DropdownMenuItem<String>(
                               value: value,
                               child: Text(
                                 value,
                                 style: TextStyle(color: Colors.white),
                               ),
                             );
                           }).toList(),
                         ),
                       ),
                     ),
                     SizedBox(
                       height: 80,
                     ),
                     Center(
                       child: SizedBox(
                         height: 35,
                         width: 130,
                         child: ElevatedButton(
                             style: ElevatedButton.styleFrom(
                               primary: Color(0xffdd3953),),
                             onPressed: () async{
                               if(nameController.text.trim().isEmpty){
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
                                               child: Text('Please enter your name',style: TextStyle(color: Colors.white,fontSize: 15),
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
                               else if(aboutController.text.trim().isEmpty){
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
                                               child: Text("About field should not be empty",style: TextStyle(color: Colors.white,fontSize: 15),
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
                              else if(_currentSelectedGender.isEmpty || _currentSelectedGender == null)
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
                                             child: Text('Please select gender',style: TextStyle(color: Colors.white,fontSize: 15),
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
                              else if(_currentSelectedEthnicity.isEmpty || _currentSelectedEthnicity == null)
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
                                             child: Text('Please select Ethnicity',style: TextStyle(color: Colors.white,fontSize: 15),
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
                               else if(_currentSelectedBodyType.isEmpty || _currentSelectedBodyType == null)
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
                                             child: Text('Please select Body Type',style: TextStyle(color: Colors.white,fontSize: 15),
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
                               else if(_currentSelectedPosition.isEmpty || _currentSelectedPosition == null)
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
                                             child: Text('Please select Position',style: TextStyle(color: Colors.white,fontSize: 15),
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
                               else if(_currentSelectedRelStatus.isEmpty || _currentSelectedRelStatus == null)
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
                                             child: Text('Please select Relationship status',style: TextStyle(color: Colors.white,fontSize: 15),
                                                 textAlign: TextAlign.left),
                                           ) ,
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
                                 final prefs = await SharedPreferences.getInstance();
                                 var email1 = await prefs.getString('email');
                                 String? email = email1;
                                 String name=nameController.text.trim();
                                 String gender= "Male";
                                 String about = aboutController.text.trim();
                                 String age = startAgeText;
                                 String height =startHeightText;
                                 String weight =startWeightText;
                                 String ethnicity = _currentSelectedEthnicity;
                                 String body_type=_currentSelectedBodyType;
                                 String position = _currentSelectedPosition;
                                 String relationship_status = _currentSelectedRelStatus;
                                 String hiv_status = "negative";
                                 var resp =await ApiService.updateProfile(email: email,name : name,gender : gender,about : about, age: age,height: height,weight: weight, ethnicity: ethnicity, position: position, body_type: body_type,relationship_status: relationship_status,hiv_status: hiv_status);
                                 if(resp == "Data"){
                                   Fluttertoast.showToast(msg: 'Profile updated successfully');
                                 }
                                 print(resp);
                               }
                             },
                             child: Text("Update")),
                       ),
                     ),
                     SizedBox(
                       height: 80,
                     ),
                 ],
               )
        )
          :    Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
      children: [
                Container(
                  margin: EdgeInsets.all(20),
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    color: Colors.purple,
                    strokeWidth: 5,
                  ),
                ),
              ],
            ),
          ),
      );

  }
}
