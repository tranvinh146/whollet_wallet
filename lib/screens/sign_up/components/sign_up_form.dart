import 'package:flutter/material.dart';
import 'package:whollet_wallet/blocs/sign_up_bloc.dart';
import 'package:whollet_wallet/components/account_text.dart';
import 'package:whollet_wallet/components/dialog/loading_dialog.dart';
import 'package:whollet_wallet/components/dialog/msg_dialog.dart';
import 'package:whollet_wallet/components/primary_button.dart';
import 'package:whollet_wallet/screens/home/home_screen.dart';
import 'package:whollet_wallet/screens/login/login_screen.dart';

import '../../../constant.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  SignUpBloc signUpBloc = SignUpBloc();

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    signUpBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildNameFormField(
                text: "First Name",
                stream: signUpBloc.firstNameStream,
                controller: _firstNameController),
            buildNameFormField(
                text: "Last Name",
                stream: signUpBloc.lastNameStream,
                controller: _lastNameController),
            buildEmailFormField(),
            buildPasswordFormField(),
            SizedBox(height: 50),
            PrimaryButton(
              text: "Let's Get Started",
              press: _onSignUpClicked,
            ),
            SizedBox(height: 16),
            AccountText(
              text1: "Already have an account? ",
              text2: "Login",
              press: () {
                Navigator.popAndPushNamed(context, LoginScreen.routeName);
              },
            )
          ],
        ),
      ),
    );
  }

  StreamBuilder<dynamic> buildPasswordFormField() {
    return StreamBuilder(
      stream: signUpBloc.passwordStream,
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
      stream: signUpBloc.emailStream,
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

  StreamBuilder<dynamic> buildNameFormField(
      {String? text, TextEditingController? controller, Stream? stream}) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) => TextFormField(
        controller: controller,
        style: TextStyle(
          color: wMidnightBlue,
          fontSize: 19,
        ),
        decoration: InputDecoration(
          labelText: text,
          labelStyle: TextStyle(
            color: wGray,
          ),
          alignLabelWithHint: true,
          hintText: text,
          hintStyle: TextStyle(
            color: wDarkGray,
          ),
          errorText: snapshot.hasError ? snapshot.error.toString() : null,
        ),
      ),
    );
  }

  _onSignUpClicked() {
    bool isValid = signUpBloc.isValid(
        _firstNameController.text,
        _lastNameController.text,
        _emailController.text,
        _passwordController.text);
    if (isValid) {
      LoadingDialog.showLoadingDialog(context, "Loading...");
      signUpBloc.signUp(_firstNameController.text, _lastNameController.text,
          _emailController.text, _passwordController.text, () {
        LoadingDialog.hideLoadingDialog(context);
        Navigator.popAndPushNamed(context, HomeScreen.routeName);
      }, (msg) {
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, "Sign up", msg);
      });
    }
  }
}
