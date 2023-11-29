import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_tuwaiq/bloc/qr_scan_cubit/qr_scan_cubit.dart';

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
                          ? Column(
                              children: [
                                ...List.generate(state.data.length, (index) {
                                  return Text(state.data[index]);
                                }),
                              ],
                            )
                          : const SizedBox(),
                      ElevatedButton(
                          onPressed: () {
                            context.read<QrScanCubit>().scanQR();
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
