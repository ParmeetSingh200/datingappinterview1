import 'dart:convert';

// List<Signup> signupFromJson(String str) => List<Signup>.from(json.decode(str).map((x) => Signup.fromJson(x)));


class SignupModel {
  Signup? signup;

  SignupModel({this.signup});

  SignupModel.fromJson(Map<String, dynamic> json) {
    signup =
    json['Signup'] != null ? new Signup.fromJson(json['Signup']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.signup != null) {
      data['Signup'] = this.signup!.toJson();
    }
    return data;
  }
}

class Signup {
  String? id;
  String? name;
  String? gender;
  String? email;
  String? dateOfBirth;
  bool? error;
  String? message;

  Signup(
      {this.id,
        this.name,
        this.gender,
        this.email,
        this.dateOfBirth,
        this.error,
        this.message});

  Signup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
    error = json['error'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['date_of_birth'] = this.dateOfBirth;
    data['error'] = this.error;
    data['message'] = this.message;
    return data;
  }
}
