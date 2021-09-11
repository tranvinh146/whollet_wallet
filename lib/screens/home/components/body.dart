import 'package:flutter/material.dart';
import 'package:whollet_wallet/firebase/whollet.dart';

class Body extends StatefulWidget {
  final Widget child;
  const Body({Key? key, required this.child}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Whollet whollet = Whollet();

  @override
  void initState() {
    whollet.getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedBody(
      whollet: whollet, 
      child: widget.child
    );
  }
}

class InheritedBody extends InheritedWidget {
  final Whollet whollet;

  InheritedBody({required Widget child, required this.whollet})
      : super(child: child);

  @override
  bool updateShouldNotify(InheritedBody oldWidget) {
    return false;
  }

  static InheritedBody of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType()!;
  }
}
