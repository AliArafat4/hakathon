part of 'qr_scan_cubit.dart';

@immutable
abstract class QrScanState {}

class QrScanInitial extends QrScanState {}

class QrScanDataState extends QrScanState {
  final DataInfoModel data;

  QrScanDataState({required this.data});
}
