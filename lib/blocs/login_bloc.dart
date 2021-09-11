import 'dart:async';

import 'package:whollet_wallet/firebase/authentication.dart';

class LoginBloc {
  Authentication _loginBloc = Authentication();

  StreamController _emailController = StreamController();
  StreamController _passController = StreamController();

  Stream get emailStream => _emailController.stream;
  Stream get passwordStream => _passController.stream;

  bool isValid(String? email, String? password) {
    if (email == null || email.length == 0) {
      _emailController.sink.addError("Please enter email");
      return false;
    }
    _emailController.sink.add("");

    if (password == null || password.length == 0) {
      _passController.sink.addError("Please enter password");
      return false;
    }
    _passController.sink.add("");

    return true;
  }

  void login(String email, String password,
      Function() onSuccess, Function(String) onError) {
    _loginBloc.login(email, password, onSuccess, onError);
  }

  void dispose() {
    _emailController.close();
    _passController.close();
  }
}
