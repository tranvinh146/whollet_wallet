import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_icon_network/flutter_icon_network.dart';

class Whollet {
  DocumentReference docRef = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  double? balance;
  String? address;
  String? _privateKey;

  void getInfo() {
    docRef.get().then((snapshot) {
      this._privateKey = snapshot.get('private_key');
      this.address = snapshot.get('address');
    });
    print(this.address);
  }

  void checkBalance() async {
    final balance = await FlutterIconNetwork.instance!
        .getIcxBalance(privateKey: _privateKey);
    docRef.update({"balance": balance.icxBalance});
  }

  void transfer(String? toAddress, String? amount, Function() onSuccess,
      Function() onError) async {
    try {
      await FlutterIconNetwork.instance!
          .sendIcx(
              yourPrivateKey: _privateKey,
              destinationAddress: toAddress,
              value: amount)
          .then((value) {
        checkBalance();
        onSuccess();
      });
    } catch (e) {
      onError();
    }
  }
}
