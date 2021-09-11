import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget? childTop;
  final Widget? childBottom;
  final double? topRatio;
  final double? bottomRatio;
  const Background({
    Key? key,
    this.childTop,
    this.topRatio = 0.3,
    this.childBottom,
    this.bottomRatio = 0.55,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      color: Color(0xFFEDF1F9),
      child: Stack(
        children: [
          Container(
            alignment: AlignmentDirectional.bottomEnd,
            height: MediaQuery.of(context).size.height * (topRatio ?? 0.3),
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: childTop,
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * (bottomRatio ?? 0.55),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                child: childBottom,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
