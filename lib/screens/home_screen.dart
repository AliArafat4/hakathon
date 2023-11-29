import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_tuwaiq/bloc/profile_cubit/profile_cubit.dart';
import 'package:hackathon_tuwaiq/bloc/qr_generate_cubit/qr_generator_cubit.dart';
import 'package:hackathon_tuwaiq/screens/auth/components/auth_button.dart';
import 'package:hackathon_tuwaiq/screens/profile_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mark Attendance"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()));
              },
              icon: const Icon(Icons.person))
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<QrGeneratorCubit, QrGeneratorState>(
              builder: (context, state) {
                state is QrGeneratorInitial
                    ? context.read<QrGeneratorCubit>().generateQrEvent()
                    : const SizedBox();
                return state is GenerateState
                    ? QrImageView(
                        data: [
                          (state.id),
                          (state.name),
                          (state.email),
                          (state.course),
                          "${state.time}",
                        ].toString(),
                        version: QrVersions.auto,
                        size: 200.0,
                      )
                    : const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      );
              },
            ),
            BlocBuilder<QrGeneratorCubit, QrGeneratorState>(
              builder: (context, state) {
                return AuthButton(
                    content: "Generate New Qr Code",
                    onPressedFunc: () {
                      context.read<QrGeneratorCubit>().generateQrEvent();
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}