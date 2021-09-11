import 'package:flutter/material.dart';
import 'package:whollet_wallet/components/background.dart';

import 'sign_up_form.dart';


class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      childTop: Container(
        constraints: BoxConstraints.expand(),
        child: Image.asset("assets/images/office.png"),
      ),
      topRatio: 0.3,
      childBottom: SignUpForm(),
      bottomRatio: 0.55,
    );
  }
}
