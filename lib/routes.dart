import 'package:helpzz/pages/auth/signin.dart';
import 'package:helpzz/pages/auth/signup.dart';
import 'package:helpzz/pages/buySell/buySellForm.dart';
import 'package:helpzz/pages/home/homepage.dart';
import 'package:helpzz/pages/splash.dart';

final routes = {
  SplashScreen.id : (context) => const SplashScreen(),
  HomePage.id: (context) => const HomePage(),
  LoginScreen.id: (context) => const LoginScreen(),
  SignupScreen.id: (context) => const SignupScreen()
};