import 'package:flutter/material.dart';
import 'package:whollet_wallet/components/account_text.dart';
import 'package:whollet_wallet/components/primary_button.dart';
import 'package:whollet_wallet/screens/login/login_screen.dart';
import 'package:whollet_wallet/screens/sign_up/sign_up_screen.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(flex: 4),
        Image.asset("assets/images/logo.png"),
        Spacer(flex: 1),
        Text(
          "Welcome to",
          style: TextStyle(
            fontSize: 28,
            color: Colors.white54,
          ),
        ),
        Text(
          "WHOLLET",
          style: TextStyle(
              color: Colors.white,
              height: 1.125,
              fontSize: 48,
              fontWeight: FontWeight.w300),
        ),
        Spacer(flex: 10),
        Column(
          children: [
            PrimaryButton(
              text: "Sign In",
              press: () {
                Navigator.popAndPushNamed(context, LoginScreen.routeName);
              },
              whiteBackground: true,
            ),
            SizedBox(
              height: 16,
            ),
            AccountText(
              text1: "Don’t have an account? ",
              colorText1: Colors.white,
              text2: "Sign Up",
              colorText2: Colors.white,
              press: () {
                Navigator.popAndPushNamed(context, SignUpScreen.routeName);
              },
            ),
          ],
        ),
        Spacer(flex: 2),
      ],
    );
  }
}
