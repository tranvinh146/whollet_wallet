import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_network/flutter_icon_network.dart';
import 'package:whollet_wallet/screens/welcome/welcome_screen.dart';

import '../constant.dart';
import '../routes.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initFlutterFire() async => await Firebase.initializeApp();
  void initIconNetwork() async => await FlutterIconNetwork.instance!.init(host: "https://bicon.net.solidwallet.io/api/v3", isTestNet: true);

  @override
  void initState() {
    initFlutterFire();
    initIconNetwork();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whollet wallet',
      theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFEDF1F9),
          fontFamily: 'TitilliumWeb',
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(
              backgroundColor: Color(0xFFEDF1F9),
              elevation: 0,
              centerTitle: true,
              textTheme: TextTheme(
                  headline6: TextStyle(
                color: wMidnightBlue,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )),
              titleTextStyle: TextStyle(
                color: Colors.red,
              ))),
      initialRoute: WelcomeScreen.routeName,
      routes: routes,
    );
  }
}
