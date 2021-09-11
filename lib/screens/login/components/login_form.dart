import 'package:flutter/material.dart';
import 'package:whollet_wallet/blocs/login_bloc.dart';
import 'package:whollet_wallet/components/account_text.dart';
import 'package:whollet_wallet/components/dialog/loading_dialog.dart';
import 'package:whollet_wallet/components/dialog/msg_dialog.dart';
import 'package:whollet_wallet/components/primary_button.dart';
import 'package:whollet_wallet/screens/home/home_screen.dart';
import 'package:whollet_wallet/screens/sign_up/sign_up_screen.dart';

import '../../../constant.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  LoginBloc loginBloc = LoginBloc();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildEmailFormField(),
            buildPasswordFormField(),
            SizedBox(height: 60),
            PrimaryButton(
              text: "Login",
              press: _onLoginClicked,
            ),
            SizedBox(height: 16),
            AccountText(
              text1: "Don't have an account? ",
              text2: "Sign Up",
              press: () {
                Navigator.popAndPushNamed(context, SignUpScreen.routeName);
              },
            )
          ],
        ),
      ),
    );
  }

  StreamBuilder<dynamic> buildPasswordFormField() {
    return StreamBuilder(
      stream: loginBloc.passwordStream,
      builder: (context, snapshot) => TextFormField(
        controller: _passwordController,
        obscureText: true,
        style: TextStyle(
          color: wMidnightBlue,
          fontSize: 19,
        ),
        decoration: InputDecoration(
          labelText: "Password",
          labelStyle: TextStyle(
            color: wGray,
          ),
          alignLabelWithHint: true,
          hintText: "Password",
          hintStyle: TextStyle(
            color: wDarkGray,
          ),
          errorText: snapshot.hasError ? snapshot.error.toString() : null,
          suffixIcon: Container(
            padding: EdgeInsets.only(top: 25),
            child: Icon(Icons.visibility_outlined),
          ),
        ),
      ),
    );
  }

  StreamBuilder<dynamic> buildEmailFormField() {
    return StreamBuilder(
      stream: loginBloc.emailStream,
      builder: (context, snapshot) => TextFormField(
        controller: _emailController,
        style: TextStyle(
          color: wMidnightBlue,
          fontSize: 19,
        ),
        decoration: InputDecoration(
          labelText: "Email address",
          labelStyle: TextStyle(
            color: wGray,
          ),
          alignLabelWithHint: true,
          hintText: "Email address",
          hintStyle: TextStyle(
            color: wDarkGray,
          ),
          errorText: snapshot.hasError ? snapshot.error.toString() : null,
        ),
      ),
    );
  }

  _onLoginClicked() {
    bool isValid =
        loginBloc.isValid(_emailController.text, _passwordController.text);
    if (isValid) {
      LoadingDialog.showLoadingDialog(context, "Loading...");
      loginBloc.login(_emailController.text, _passwordController.text, () {
        LoadingDialog.hideLoadingDialog(context);
        Navigator.popAndPushNamed(context, HomeScreen.routeName);
      }, (msg) {
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, "Login", msg);
      });
    }
  }
}
