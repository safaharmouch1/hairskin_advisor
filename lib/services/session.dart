import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static Future<int?> userId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt("user_id");
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("user_id");
  }
}
