import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whollet_wallet/blocs/transfer_bloc.dart';
import 'package:whollet_wallet/components/dialog/loading_dialog.dart';
import 'package:whollet_wallet/components/dialog/msg_dialog.dart';
import 'package:whollet_wallet/components/primary_button.dart';
import 'package:whollet_wallet/screens/home/components/body.dart';

import '../../../constant.dart';

class Transfer extends StatefulWidget {
  const Transfer({
    Key? key,
  }) : super(key: key);

  @override
  _TransferState createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  TransferBloc transferBloc = TransferBloc();

  TextEditingController _addressController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    transferBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "My Address",
            style: TextStyle(
              color: wMidnightBlue,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (!snapshot.hasData) return Text('--');
                    return Text(
                      snapshot.data!['address'],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: wMidnightBlue,
                        fontSize: 20,
                      ),
                    );
                  },
                ),
              ),
              Spacer(),
              IconButton(
                  onPressed: () {
                    final data = ClipboardData(
                        text: InheritedBody.of(context).whollet.address);
                    Clipboard.setData(data);
                  },
                  icon: Icon(Icons.copy)),
            ],
          ),
          SizedBox(height: 30),
          Text(
            "Transfer ICX",
            style: TextStyle(
              color: wMidnightBlue,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          buildAddressField(),
          buildAmountField(),
          Container(
            padding: EdgeInsets.fromLTRB(40, 35, 40, 0),
            width: double.infinity,
            child: PrimaryButton(
              text: "Transfer",
              press: _onClickedTransfer,
            ),
          ),
        ],
      ),
    );
  }

  StreamBuilder<dynamic> buildAddressField() {
    return StreamBuilder(
      stream: transferBloc.addressStream,
      builder: (context, snapshot) => TextField(
        controller: _addressController,
        style: TextStyle(
          color: wMidnightBlue,
          fontSize: 19,
        ),
        decoration: InputDecoration(
          labelText: "Destination address",
          labelStyle: TextStyle(
            color: wGray,
          ),
          alignLabelWithHint: true,
          hintText: "Destination address",
          hintStyle: TextStyle(
            color: wDarkGray,
          ),
          errorText: snapshot.hasError ? snapshot.error.toString() : null,
        ),
      ),
    );
  }

  StreamBuilder<dynamic> buildAmountField() {
    return StreamBuilder(
      stream: transferBloc.amountStream,
      builder: (context, snapshot) => TextField(
        controller: _amountController,
        keyboardType: TextInputType.number,
        style: TextStyle(
          color: wMidnightBlue,
          fontSize: 19,
        ),
        decoration: InputDecoration(
          labelText: "Amount ICX",
          labelStyle: TextStyle(
            color: wGray,
          ),
          alignLabelWithHint: true,
          hintText: "Amount ICX",
          hintStyle: TextStyle(
            color: wDarkGray,
          ),
          errorText: snapshot.hasError ? snapshot.error.toString() : null,
        ),
      ),
    );
  }

  _onClickedTransfer() {
    bool isValid =
        transferBloc.isValid(_addressController.text, _amountController.text);
    if (isValid) {
      LoadingDialog.showLoadingDialog(context, "Loading...");
      InheritedBody.of(context)
          .whollet
          .transfer(_addressController.text, _amountController.text, () {
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, "Success", "Transfer success!");
      }, () {
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(
            context, "Fail", "Transfer failed! Please try again.");
      });
    }
  }
}
