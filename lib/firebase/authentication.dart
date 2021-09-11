import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_icon_network/flutter_icon_network.dart';

class Authentication {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void signUp(String firstName, String lastName, String email, String password,
      Function onSuccess, Function(String) onError) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => _addInfo(
              value.user!.uid, firstName, lastName, onSuccess, onError));
    } on FirebaseAuthException catch (e) {
      _onSignUpError(e.code, onError);
    } catch (e) {
      _onSignUpError(e.toString(), onError);
    }
  }

  void _addInfo(String uid, String firstName, String lastName,
      Function onSuccess, Function(String) onError) async {
    final wallet = await FlutterIconNetwork.instance!.createWallet;
    final balance = await FlutterIconNetwork.instance!
        .getIcxBalance(privateKey: wallet.privateKey);
    DocumentReference users =
        FirebaseFirestore.instance.collection('users').doc(uid);

    users
        .set({
          'first_name': firstName,
          'last_name': lastName,
          'address': wallet.address,
          'private_key': wallet.privateKey,
          'balance': balance.icxBalance,
        })
        .then((value) => onSuccess())
        .catchError((onError) => onError("Sign up failed. Please try again."));
  }

  void _onSignUpError(String code, Function(String) onRegisterError) {
    switch (code) {
      case "email-already-in-use":
        onRegisterError("Email already in use");
        break;
      case "invalid-email":
        onRegisterError("Invalid Email");
        break;
      case "weak-password":
        onRegisterError("The password is not strong enough");
        break;
      default:
        onRegisterError("Sign up failed. Please try again.");
        break;
    }
  }

  void login(String email, String password, Function onSuccess,
      Function(String) onError) async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => onSuccess());
    } on FirebaseAuthException catch (e) {
      _onLoginError(e.code, onError);
    } catch (e) {
      _onLoginError(e.toString(), onError);
    }
  }

  void _onLoginError(String code, Function(String) onSignInError) {
    switch (code) {
      case "invalid-email":
        onSignInError("The email address is not valid");
        break;
      case "user-disabled":
        onSignInError("The given email has been disabled");
        break;
      case "user-not-found":
        onSignInError("User not found");
        break;
      case "wrong-password":
        onSignInError("Wrong password");
        break;
      default:
        onSignInError("Sign up failed. Please try again.");
        break;
    }
  }

  void signOut() => _firebaseAuth.signOut();
  
}
