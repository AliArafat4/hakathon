import 'package:flutter/material.dart';
import 'package:hackathon_tuwaiq/bloc/qr_scan_cubit/qr_scan_cubit.dart';

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
        ListTile(
          title: Text("${state.data.name}"),
          subtitle: Text("Registered in:${state.data.courseName} course"),
          trailing: const Icon(
            Icons.check_box,
            color: Colors.green,
            size: 25,
          ),
        ),
      ],
    );
  }
}
