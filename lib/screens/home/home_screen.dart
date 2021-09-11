import 'package:flutter/material.dart';
import 'package:whollet_wallet/components/background.dart';
import 'package:whollet_wallet/firebase/authentication.dart';
import 'package:whollet_wallet/screens/home/components/transfer.dart';
import 'package:whollet_wallet/screens/login/login_screen.dart';

import 'components/balance.dart';
import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/hone_screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Authentication _auth = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        child: Background(
          childTop: Balance(),
          topRatio: 0.4,
          childBottom: Transfer(),
          bottomRatio: 0.68,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _auth.signOut();
          Navigator.popAndPushNamed(context, LoginScreen.routeName);
        },
        child: Icon(Icons.exit_to_app),
      ),
    );
  }
}

