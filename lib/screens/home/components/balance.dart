import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';
import 'body.dart';

class Balance extends StatelessWidget {
  const Balance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      constraints: BoxConstraints.expand(),
      alignment: Alignment.topCenter,
      color: wPrimaryBlue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Spacer(flex: 8),
              Text(
                "BALANCE",
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
              Spacer(flex: 1),
              TextButton(
                onPressed: InheritedBody.of(context).whollet.checkBalance,
                child: Icon(
                  Icons.refresh_outlined,
                  size: 25,
                  color: Colors.white,
                ),
              ),
              Spacer(flex: 5),
            ],
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (!snapshot.hasData) return Text('--');
              return Text(
                snapshot.data!['balance'].toStringAsFixed(2) + " ICX",
                style: TextStyle(
                    fontSize: 34,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              );
            },
          ),
          SizedBox(height: 30,)
        ],
      ),
    );
  }
}
