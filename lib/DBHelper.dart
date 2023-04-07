import 'package:shared_preferences/shared_preferences.dart';

class DbHelper {

  static createData({required String key, required dynamic value}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(key, value);
  }

  static Future readData({required String key}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var value = await pref.getString(key);
    return value;
  }

  static Future deleteData({required String key}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove(key);
  }

  static eraseData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}