import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_tuwaiq/bloc/qr_scan_cubit/qr_scan_cubit.dart';
import 'package:hackathon_tuwaiq/db/supabase_db.dart';
import 'package:hackathon_tuwaiq/screens/scan_qr/components/user_data.dart';

class QrScannerScreen extends StatelessWidget {
  const QrScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<QrScanCubit, QrScanState>(
              builder: (context, state) {
                state is QrScanInitial
                    ? context.read<QrScanCubit>().scanQR()
                    : const SizedBox();
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      state is QrScanDataState
                          ? UserDataWidget(state: state)
                          : const SizedBox(),
                      ElevatedButton(
                          onPressed: () {
                            context.read<QrScanCubit>().scanQR();
                          },
                          child: const Text("Scan")),
                    ],
                  ),
                );
              },
              listener: (BuildContext context, QrScanState state) async {
                if (state is QrScanDataState) {
                  await SupaBaseDB().markStudentAttendance(
                      userId: state.data.userId!,
                      studentId: state.data.studentId);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
