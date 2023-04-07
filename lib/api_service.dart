import 'dart:convert';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gaydatingapp/model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'signup_page.dart';
import 'model/signup_model.dart';
import 'dart:io';

class ApiService {
 static Future<SignupModel?> postUsers(String gender,String dob,String name,String email,String psswd,String conpsswd) async {
    try {
      var url = Uri.parse("http://nexever.in/dating/api.php?signup");
      final response = await post(url, body: {
        "name": name,
        "gender": gender,
        "email": email,
        "date_of_birth": dob,
        "password": psswd,
        "confirm_password": conpsswd,
      });
      if (response.statusCode == 200) {
        print(response.body);
        print(response.statusCode);
        // List<Signup> _model = signupFromJson(response.body);
        // return _model;
        return SignupModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      log(e.toString());
    }
  }
 static Future<LoginModel?> postUserslogin(String email,String psswd) async {
   try {
     var url = Uri.parse("http://nexever.in/dating/api.php?login");
     final response = await post(url, body: {
      "email": email,
      "password": psswd
     });
     if (response.statusCode == 200) {
       print(response.body);
       print(response.statusCode);
       // LoginModel _model = (response.body);
       return LoginModel.fromJson(jsonDecode(response.body));

     }
   } catch (e) {
     log(e.toString());
   }
 }

static Future searchConnections({
   required String? email,
   required String age_range,
   required String ethnicity,
   required String position,
   required String body_type,
 })async{
   var body = {
     'email': email,
     'age_range': age_range,
     'ethnicity': ethnicity,
     'position': position,
     'body_type': body_type,
   };
   try{
     var response = await http.post(Uri.parse("http://nexever.in/dating/api.php?add_preferences"), body: body);
     if (response.statusCode == 200) {
        print(response.body);
        return json.decode(response.body);
     } else {
       print('failed to get data');
       throw Exception('Failed to get data');
     }
   }catch(e){
   }
 }

 static Future updateProfile({
   required String? email,
   required String? name,
   required String gender,
   required String about,
   required String age,
   required String height,
   required String weight,
   required String ethnicity,
   required String body_type,
   required String position,
   required String relationship_status,
   required String hiv_status,
 })async{
   var body = {
     'email':email,
     'name': name,
     'about': about,
     'age': age,
     'gender': gender,
     'height':height,
     'weight': weight,
     'ethnicity': ethnicity,
     'position': position,
     'body_type': body_type,
     'position': position,
     'relationship_status': relationship_status,
     'hiv_status':hiv_status,
   };
   try{
     var response = await http.post(Uri.parse("http://nexever.in/dating/api.php?update_profile"), body: body);
     if (response.statusCode == 200) {
        print(response.body);
       // return json.decode(response.body);
       return "Data";
     } else {
       print('failed to get data');
       throw Exception('Failed to get data');
     }
   }catch(e){

   }
 }

 static Future updatePhone({
   required String? email,
   required String phonenumber,
 })async{
   var body = {
     'email': email,
     'phone': phonenumber,
   };
   try{
     var response = await http.post(Uri.parse("http://nexever.in/dating/api.php?phone_update"), body: body);
     if (response.statusCode == 200) {
        print(response.body);
       // return json.decode(response.body);
       return "Data";
     } else {
       print('failed to get data');
       throw Exception('Failed to get data');
     }
   }catch(e){
   }
 }

 static Future changePassword({
   required String? email,
     required String currentpassword,
   required String newpassword,
 })async{
   var body = {
     'email': email,
     'password': currentpassword,
     'newpassword':newpassword,
   };
   try{
     var response = await http.post(Uri.parse("http://nexever.in/dating/api.php?change_password"), body: body);
     if (response.statusCode == 200) {
       print(response.body);
       // return json.decode(response.body);
       return "Data";
     } else {
       print('failed to get data');
       throw Exception('Failed to get data');
     }
   }catch(e){
   }
 }

 static Future forgotPassword({
   required String? email,
 })async{
   var body = {
     'email': email,
   };
   try{
     var response = await http.post(Uri.parse("http://nexever.in/dating/api.php?forgot_password"), body: body);
     if (response.statusCode == 200) {
       print(response.body);
       return json.decode(response.body);
       // return json.decode(response.body);
   } else {
       print('failed to get data');
       throw Exception('Failed to get data');
     }
   }catch(e){
   }
 }

 static Future getProfile({
   required String? email,
 })async{
   var body = {
     'email': email,
   };
   try{
     var response = await http.post(Uri.parse("http://nexever.in/dating/api.php?get_user"), body: body);
     if (response.statusCode == 200) {
       print(response.body);
       return json.decode(response.body);
       // return json.decode(response.body);
     } else {
       print('failed to get data');
       throw Exception('Failed to get data');
     }
   }catch(e){
   }
 }

 static Future getPrefs({
   required String? email,
 })async{
   var body = {
     'email': email,
   };
   try{
     var response = await http.post(Uri.parse("http://nexever.in/dating/api.php?get_preferences"), body: body);
     if (response.statusCode == 200) {
       print(response.body);
       return json.decode(response.body);
       // return json.decode(response.body);
     } else {
       print('failed to get data');
       throw Exception('Failed to get data');
     }
   }catch(e){
   }
 }

 static Future delAccount({
   required String? email,
 })async{
   var body = {
     'email': email,
   };
   try{
     var response = await http.post(Uri.parse("http://nexever.in/dating/api.php?delete_account"), body: body);
     if (response.statusCode == 200) {
       print(response.body);
       return json.decode(response.body);
       // return json.decode(response.body);
     } else {
       print('failed to get data');
       throw Exception('Failed to get data');
     }
   }catch(e){
   }
 }


 static Future updateImage({
   required String? email,
   required String? image,
 }) async {
   print("object");
   try {
     var uri = Uri.parse("http://nexever.in/dating/api.php?update_image");
     http.MultipartRequest request = http.MultipartRequest("POST", uri);
     request.fields['email'] = email!;
     request.files.add(
         http.MultipartFile.fromBytes(
             'image',
             File(image!).readAsBytesSync(),
             filename: image.split("/").last
         ));
     // request.files.add(await http.MultipartFile.fromPath(
     //     'image', image!));
     // http.StreamedResponse response = await request.send();
     print(email);
     print(image);
     var res = await request.send();
     // res.stream.transform(utf8.decoder).listen((event) {});
     // return res.reasonPhrase;
     print("response");
    print(res.request);
    print(res.reasonPhrase);
    if(res.statusCode == 200){
      return "Data";
    }
   } catch (e) {
     Fluttertoast.showToast(msg: "Something went wrong!");
   }
 }
}