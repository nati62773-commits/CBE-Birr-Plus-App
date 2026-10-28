import 'package:shared_preferences/shared_preferences.dart';

class UserSession {
  // These variables hold your details while the app is running
  static String fullName = "";
  static String accountNo = "";
  static String phoneNo = "";

  // This function runs when the app opens to check if we saved your details before
  static Future<void> loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fullName = prefs.getString('fullName') ?? "";
    accountNo = prefs.getString('accountNo') ?? "";
    phoneNo = prefs.getString('phoneNo') ?? "";
  }

  // This function saves your details permanently to the phone
  static Future<void> saveUser(String name, String account, String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('fullName', name);
    await prefs.setString('accountNo', account);
    await prefs.setString('phoneNo', phone);
    
    // Update the app's memory immediately
    fullName = name;
    accountNo = account;
    phoneNo = phone;
  }
}
