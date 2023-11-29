import 'package:flutter/material.dart';
import 'package:hackathon_tuwaiq/bloc/profile_cubit/profile_cubit.dart';
import 'package:intl/intl.dart';

class AttendanceRecordWidget extends StatelessWidget {
  const AttendanceRecordWidget({
    super.key,
    required this.state,
  });
  final ProfileInfoState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
          state.attendanceRecord.length,
          (index) => ListTile(
              leading: Text(DateFormat.E().format(DateTime.parse(
                  state.attendanceRecord[index].attendanceDate!))),
              subtitle: Text(DateFormat.Hms().format(DateTime.parse(
                  state.attendanceRecord[index].attendanceDate!))),
              title: Text(DateFormat.yMMMd().format(DateTime.parse(
                  state.attendanceRecord[index].attendanceDate!)))),
        )
      ],
    );
  }
}
