import 'package:flutter/material.dart';
import 'package:whollet_wallet/components/background.dart';

import 'login_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      childTop: Container(
        constraints: BoxConstraints.expand(),
        child: Image.asset("assets/images/login.png"),
      ),
      topRatio: 0.34,
      childBottom: LoginForm(),
    );
  }
}
