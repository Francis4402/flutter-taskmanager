import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/data/user_data.dart';

class AuthController {
  static String? accessToken;
  static UserData? userData;

  static const String _userDataKey = 'userData';
  static const String _tokenKey = 'token';

  static Future<void> saveUserData(UserData userData) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userDataKey, jsonEncode(userData.toJson()));
    AuthController.userData = userData;
  }

  static Future<UserData?> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? result = sharedPreferences.getString(_userDataKey);
    if(result == null){
      return null;
    }
    final user = UserData.fromJson(jsonDecode(result));
    AuthController.userData = user;
    return user;
  }

  static Future<void> saveUserToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_tokenKey, token);
    accessToken = token;
  }

  static Future<String?> getUserToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_tokenKey);
  }

  static Future<bool> isLoggedIn() async {
    final result = await getUserToken();
    accessToken = result;
    bool loginState = result != null;
    if(loginState) {
      await getUserData();
    }
    return loginState;
  }

  static Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(_userDataKey);
    await sharedPreferences.remove(_tokenKey);
    accessToken = null;
    userData = null;
  }
}
