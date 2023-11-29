import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:meta/meta.dart';

part 'qr_scan_state.dart';

class QrScanCubit extends Cubit<QrScanState> {
  QrScanCubit() : super(QrScanInitial());

  Future<dynamic> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

      List<String> data =
          barcodeScanRes.substring(1, barcodeScanRes.length - 1).split(",");

      emit(QrScanDataState(data: data));
    } on PlatformException {
      return barcodeScanRes = 'Failed to get platform version.';
    }
  }
}
