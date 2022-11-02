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
class LoginScreen extends StatefulWidget {
  static const id = "/signin";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var useremail;
  var password;
  final formKey = GlobalKey<FormState>();
  bool signin=false;

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
                    "Login to App",
                    style: MyFonts.w800.size(30).setColor(lBlue2),
                  ),),
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
                        hintText: 'Enter Password',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        fillColor: kAppBarGrey,
                        filled: true,
                        hintStyle: MyFonts.w500.size(15).setColor(kGrey10),
                      ),
                    ),
                  ),
                  Container(height: 23,),
                  Builder(builder: (builderContext) => GestureDetector(
                    onTap: () async {
                      bool isValid = formKey.currentState!.validate();
                      if (!isValid) {
                        return;
                      }
                      print(useremail);
                      print(password);
                      setState(() {
                        signin=true;
                      });
                      Map res = await APIService.login(useremail, password);
                      Scaffold.of(builderContext).showSnackBar(SnackBar(content: Text(res["result"])));
                      if(res["success"]){
                        context.read<User>().saveToPreferences({'email':useremail,'name':res["username"]});
                        context.read<User>().saveUserData();
                        Navigator.pushReplacementNamed(context, HomePage.id);
                      }
                      else{
                        setState(() {
                          signin=false;
                        });
                      }
                    },
                    child: const NextButton(title: "Continue Login")
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ?",
                        style: MyFonts.w500.size(15).setColor(kGrey10)
                      ),
                      TextButton(
                          onPressed: (){
                            Navigator.of(context).pushReplacementNamed('/signup');
                          }, child: Text(
                        "SignUp",
                        style: MyFonts.w500.size(15).setColor(lBlue2)
                      ))
                    ],
                  )
                ],
              ),
            ),
          ),
          SavingOverlayScreen(visible: signin)
        ],
      ),
    );
  }
}

