import 'package:flutter/material.dart';
import 'package:whollet_wallet/screens/home/home_screen.dart';
import 'package:whollet_wallet/screens/login/login_screen.dart';
import 'package:whollet_wallet/screens/sign_up/sign_up_screen.dart';
import 'package:whollet_wallet/screens/welcome/welcome_screen.dart';

final Map<String, WidgetBuilder> routes = {
  WelcomeScreen.routeName: (context) => WelcomeScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
};
