import 'package:flutter/material.dart';

import '../constant.dart';

class AccountText extends StatelessWidget {
  final String? text1;
  final Color? colorText1;
  final String? text2;
  final Color? colorText2;
  final Function()? press;
  const AccountText({
    Key? key,
    this.text1,
    this.colorText1,
    this.text2,
    this.colorText2,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text1!,
          style: TextStyle(
              color: colorText1??Color(0xFF485068),
              fontSize: 15
          ),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            text2!,
            style: TextStyle(
              color: colorText2??wPrimaryBlue,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }
}