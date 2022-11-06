import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class User{
  String email="";
  String name="";

  Future<void> saveToPreferences(Map<String,dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', data["email"]);
    prefs.setString('name', data["name"]);
  }

  Future<bool> isAlreadyAuthenticated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("name")) {
      saveUserData();
      return true;
    }
    return false;
  }

  Future<void> saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email= prefs.getString('email') ?? " ";
    name= prefs.getString('name') ?? " ";
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

}