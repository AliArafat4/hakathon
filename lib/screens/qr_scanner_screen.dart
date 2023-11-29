import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_tuwaiq/bloc/qr_scan_cubit/qr_scan_cubit.dart';
import 'package:hackathon_tuwaiq/db/supabase_db.dart';

class QrScannerScreen extends StatelessWidget {
  const QrScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<QrScanCubit, QrScanState>(
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
                          onPressed: () async {
                            await context.read<QrScanCubit>().scanQR();
                            if (state is QrScanDataState) {
                              SupaBaseDB().markStudentAttendance(
                                  userId: state.data.userId!,
                                  studentId: state.data.studentId);
                            }
                          },
                          child: const Text("Scan"))
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class UserDataWidget extends StatelessWidget {
  const UserDataWidget({
    super.key,
    required this.state,
  });
  final QrScanDataState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Name: ${state.data.name}"),
        Text("Email: ${state.data.email}"),
        Text("Registered in${state.data.courseName} course"),
      ],
    );
  }
}
