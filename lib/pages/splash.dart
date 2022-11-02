import 'package:flutter/material.dart';
import 'package:helpzz/globals/colors.dart';
import 'package:helpzz/globals/my_fonts.dart';
import 'package:helpzz/models/user.dart';
import 'package:helpzz/pages/auth/signin.dart';
import 'package:helpzz/pages/home/homepage.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/animation_builder/play_animation_builder.dart';
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
    Future.delayed(Duration(seconds: 3)).then((value) => {
    context.read<User>().isAlreadyAuthenticated().then((res) => {
      if(res==true){
      Navigator.pushReplacementNamed(context, HomePage.id)
    }
    else{
      Navigator.pushReplacementNamed(context, LoginScreen.id)
    }
      })
    });
  }
  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBlack,
      body: Center(
        child: PlayAnimationBuilder<double>(
          tween: Tween(begin: screenwidth*0.2, end: screenwidth-40), // set tween
          duration: const Duration(seconds: 3), // set duration
          builder: (context, value, _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset("assets/images/app_logo.png",width: value,),
                Text("Helpzz",style: MyFonts.w600.size(26).letterSpace(1.0).setColor(lBlue2),)
              ],
            );
          },
        ),
      )
    );
  }
}

