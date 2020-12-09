// import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:rxdart/rxdart.dart';
import 'validator_mixin.dart';
import 'package:flutter/services.dart';

class BarCodeBloc extends Object with ValidatorMixin {
  final _barCodeController = BehaviorSubject<String>();

  get barCode => _barCodeController.stream.transform(validateBarCode);

  scanQR() async {
    try {
      final qrResult = await BarcodeScanner.scan();
      _barCodeController.sink.add(qrResult);
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        _barCodeController.sink
            .addError("We need your permission to access the device's camera.");
      } else {
        _barCodeController.sink.addError("Unknown Error $ex");
      }
    } on FormatException {
      _barCodeController.sink.addError("Back button has been pressed.");
    } catch (ex) {
      _barCodeController.sink.addError("Unknown Error $ex");
    }
  }

  dispose() {
    _barCodeController.close();
  }
}
