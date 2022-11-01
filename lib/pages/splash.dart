import 'package:flutter/material.dart';
import 'package:helpzz/models/user.dart';
import 'package:helpzz/pages/auth/signin.dart';
import 'package:helpzz/pages/home/homepage.dart';
import 'package:provider/provider.dart';
class SplashScreen extends StatefulWidget {
  static const id = "/";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<User>().isAlreadyAuthenticated().then((res) => {
      if(res==true){
        Navigator.pushReplacementNamed(context, HomePage.id)
      }
      else{
        Navigator.pushReplacementNamed(context, LoginScreen.id)
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

