import 'dart:convert';
import 'package:helpzz/models/buySellModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class APIService{
  static var API_URL = "https://whispering-journey-08979.herokuapp.com";

  static Future<Map<dynamic,dynamic>> signup(String username,String useremail, String password) async {
    var res = await http.post(Uri.parse(API_URL+"/signup"),
        headers: {
          'Content-Type': 'application/json',
          'security-key': "WeLoveThisWorld3000"
        },
        body: jsonEncode({
          "username" : username,
          "useremail" : useremail,
          "userpassword" : password
        }));
    var resBody=jsonDecode(res.body);
    print(resBody);
    if(res.statusCode==400){
      // print(response.data["result"]);
      return {"result":resBody["result"],"success":false};
    }
    return {"result":resBody["result"],"success":true};
  }

  static Future<Map<dynamic,dynamic>> login(String useremail,String password) async {
    var res = await http.post(Uri.parse(API_URL+"/login"),
        headers: {
          'Content-Type': 'application/json',
          'security-key': "WeLoveThisWorld3000"
        },
        body: jsonEncode({
          "useremail" : useremail,
          "userpassword" : password
        }));
    var resBody=jsonDecode(res.body);
    print(resBody);
    if(res.statusCode==400){
      // print(response.data["result"]);
      return {"result":resBody["result"],"success":false};
    }
    return {"result":resBody["result"],"success":true,"username":resBody["username"]};
  }

  static Future<List> getBuyItems() async {
    print("before");
    var res = await http.get(Uri.parse(API_URL+'/buy'));
    print("after");
    print(res.body);
    var buyItems = jsonDecode(res.body);
    print("decoded json");
    return buyItems["details"];
  }

  static Future<List> getSellItems() async {
    print("before");
    var res = await http.get(Uri.parse(API_URL+'/sell'));
    print("after");
    var sellItems = jsonDecode(res.body);
    print("decoded json");
    return sellItems["details"];
  }

  static Future<Map<dynamic,dynamic>> postItem(String category,String title, String price, String description,String contactnumber, String imageString, String username, String email) async {
    var res = await http.post(Uri.parse(API_URL+(category=="Buy" ? "/buy" : "/sell")),
        headers: {
          'Content-Type': 'application/json',
          'security-key': "WeLoveThisWorld3000"
        },
        body: jsonEncode({
          "title":title,
          "price":price,
          "description":description,
          "phonenumber":contactnumber,
          "imageString":imageString,
          "username":username,
          "email":email
        }));
    var resBody=jsonDecode(res.body);
    return resBody;
  }

}