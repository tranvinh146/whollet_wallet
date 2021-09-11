import 'dart:async';

class TransferBloc {
  StreamController _addressController = StreamController();
  StreamController _amountController = StreamController();

  Stream get addressStream => _addressController.stream;
  Stream get amountStream => _amountController.stream;

  bool isValid(String? address, String? amount) {
    if (address == null || address.length < 20) {
      _addressController.sink.addError("Please enter valid address");
      return false;
    }
    _addressController.sink.add("");

    if (amount == null || amount.length == 0) {
      _amountController.sink.addError("Please enter valid amount");
      return false;
    }
    _amountController.sink.add("");

    return true;
  }

  void dispose() {
    _addressController.close();
    _amountController.close();
  }
}
