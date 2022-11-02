import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:helpzz/globals/colors.dart';
import 'package:helpzz/globals/my_fonts.dart';
import 'package:helpzz/models/user.dart';
import 'package:helpzz/pages/home/homepage.dart';
import 'package:helpzz/services/api.dart';
import 'package:helpzz/widgets/appbar.dart';
import 'package:helpzz/widgets/nextButton.dart';
import 'package:helpzz/widgets/savingOverlay.dart';
import 'package:provider/provider.dart';
class SignupScreen extends StatefulWidget {
  static const id = "/signup";
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var username;
  var useremail;
  var password;
  final formKey = GlobalKey<FormState>();
  bool signup=false;
  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBar(screenwidth),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenheight*0.1,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 16),
                    child: Text(
                      "Create Account",
                      style: MyFonts.w800.size(30).setColor(lBlue2),
                    ),),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: TextFormField(
                      style: MyFonts.w500.size(15).setColor(kWhite),
                      onChanged: (value){
                        username=value.trim();
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter a Username',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        fillColor: kAppBarGrey,
                        filled: true,
                        hintStyle: MyFonts.w500.size(15).setColor(kGrey10),
                      ),
                      validator: (value){
                        if (value == null) {
                          return 'Field cannot be empty';
                        }
                        value=value.trim();
                        if(value.isEmpty){
                          return 'Field cannot be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: TextFormField(
                      style: MyFonts.w500.size(15).setColor(kWhite),
                      onChanged: (value){
                        useremail=value.trim();
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter Email',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        fillColor: kAppBarGrey,
                        filled: true,
                        hintStyle: MyFonts.w500.size(15).setColor(kGrey10),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value){
                        if (value == null) {
                          return 'Please enter your email';
                        }
                        value=value.trim();
                        if(value.isEmpty){
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: TextFormField(
                      style: MyFonts.w500.size(15).setColor(kWhite),
                      onChanged: (value){
                        password=value.trim();
                      },
                      validator: (value){
                        if (value == null) {
                          return 'Please enter a password';
                        }
                        value=value.trim();
                        if(value.isEmpty){
                          return 'Please enter a password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Create Password',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        fillColor: kAppBarGrey,
                        filled: true,
                        hintStyle: MyFonts.w500.size(15).setColor(kGrey10),
                      ),
                      obscureText: true,
                    ),
                  ),
                  Container(height: 23,),
                  Builder(builder: (builderContext) => GestureDetector(
                      onTap: () async {
                        bool isValid = formKey.currentState!.validate();
                        if (!isValid) {
                          return;
                        }
                        setState(() {
                          signup=true;
                        });
                        Map res = await APIService.signup(username, useremail, password);
                        Scaffold.of(builderContext).showSnackBar(SnackBar(content: Text(res["result"])));
                        if(res["success"]){
                          context.read<User>().saveToPreferences({'email':useremail,'name':username});
                          context.read<User>().saveUserData();
                          Navigator.pushReplacementNamed(context, HomePage.id);
                        }
                        else{
                          setState(() {
                            signup=false;
                          });
                        }
                      },
                      child: const NextButton(title: "Signup")
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          "Already have an account ?",
                          style: MyFonts.w500.size(15).setColor(kGrey10)
                      ),
                      TextButton(
                          onPressed: (){
                            Navigator.of(context).pushReplacementNamed('/signin');
                          }, child: Text(
                          "LogIn",
                          style: MyFonts.w500.size(15).setColor(lBlue2)
                      ))
                    ],
                  )
                ],
              ),
            ),
          ),
          SavingOverlayScreen(visible: signup)
        ],
      ),
    );
  }
}
