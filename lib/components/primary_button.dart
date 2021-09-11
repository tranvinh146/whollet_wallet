import 'package:flutter/material.dart';

import '../constant.dart';


class PrimaryButton extends StatelessWidget {
  final String? text;
  final Function()? press;
  final bool? whiteBackground;

  const PrimaryButton({
    Key? key,
    this.text,
    this.press,
    this.whiteBackground = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 46,
      child: TextButton(
        onPressed: press,
        child: Text(text!),
          style: TextButton.styleFrom(
              primary: whiteBackground==true ? wPrimaryBlue : Colors.white,
              backgroundColor:  whiteBackground==true ? Colors.white : wPrimaryBlue,
              textStyle: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.w600,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23)))
      ),
    );
  }
}
