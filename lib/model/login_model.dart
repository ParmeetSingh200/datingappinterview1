class LoginModel {
  Login? login;

  LoginModel({this.login});

  LoginModel.fromJson(Map<String, dynamic> json) {
    login = json['Login'] != null ? new Login.fromJson(json['Login']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.login != null) {
      data['Login'] = this.login!.toJson();
    }
    return data;
  }
}

class Login {
  String? id;
  String? name;
  String? about;
  String? gender;
  String? email;
  String? dateOfBirth;
  String? image;
  bool? error;
  String? quickbloxId;
  String? quickbloxPassword;
  String? message;
  String? preferences;

  Login(
      {this.id,
        this.name,
        this.about,
        this.gender,
        this.email,
        this.dateOfBirth,
        this.image,
        this.error,
        this.quickbloxId,
        this.quickbloxPassword,
        this.message,
        this.preferences});

  Login.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    about = json['about'];
    gender = json['gender'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
    image = json['image'];
    error = json['error'];
    quickbloxId = json['quickblox_id'];
    quickbloxPassword = json['quickblox_password'];
    message = json['message'];
    preferences = json['preferences'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['about'] = this.about;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['date_of_birth'] = this.dateOfBirth;
    data['image'] = this.image;
    data['error'] = this.error;
    data['quickblox_id'] = this.quickbloxId;
    data['quickblox_password'] = this.quickbloxPassword;
    data['message'] = this.message;
    data['preferences'] = this.preferences;
    return data;
  }
}
