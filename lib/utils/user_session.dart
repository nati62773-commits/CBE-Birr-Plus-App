import 'package:shared_preferences/shared_preferences.dart';

class UserSession {
  // Your permanent details for the receipts
  static String fullName = "NATNAEL TENKIR ANSA";
  static String accountNo = "100300567900";
  static String phoneNo = "0986925302";

  static Future<void> loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedName = prefs.getString('fullName');
    if (savedName != null && savedName.isNotEmpty) {
      fullName = savedName;
    }
    String? savedAccount = prefs.getString('accountNo');
    if (savedAccount != null && savedAccount.isNotEmpty) {
      accountNo = savedAccount;
    }
    String? savedPhone = prefs.getString('phoneNo');
    if (savedPhone != null && savedPhone.isNotEmpty) {
      phoneNo = savedPhone;
    }
  }
}
