import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/data_info_model.dart';

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

      if (data.isNotEmpty) {
        final ls = DataInfoModel.fromJson(data);
        emit(QrScanDataState(data: ls));
      }
    } on PlatformException {
      return barcodeScanRes = 'Failed to get platform version.';
    }
  }
}
