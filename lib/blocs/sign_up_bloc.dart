import 'dart:async';

import 'package:whollet_wallet/firebase/authentication.dart';

class SignUpBloc {
  Authentication _signUpBloc = Authentication();

  StreamController _firstNameController = StreamController();
  StreamController _lastNameController = StreamController();
  StreamController _emailController = StreamController();
  StreamController _passController = StreamController();

  Stream get firstNameStream => _firstNameController.stream;
  Stream get lastNameStream => _lastNameController.stream;
  Stream get emailStream => _emailController.stream;
  Stream get passwordStream => _passController.stream;

  bool isValid(
      String? firstName, String? lastName, String? email, String? password) {
    if (firstName == null || firstName.length == 0) {
      _firstNameController.sink.addError("Please enter first name");
      return false;
    }
    _firstNameController.sink.add("");

    if (lastName == null || lastName.length == 0) {
      _lastNameController.sink.addError("Please enter last name");
      return false;
    }
    _lastNameController.sink.add("");

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

  void signUp(String firstName, String lastName, String email, String password,
      Function() onSuccess, Function(String) onError) {
    _signUpBloc.signUp(firstName, lastName, email, password, onSuccess, onError);
  }

  void dispose() {
    _firstNameController.close();
    _lastNameController.close();
    _emailController.close();
    _passController.close();
  }
}
