part of 'profile_cubit.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {
  ProfileInitial();
}

class ProfileInfoState extends ProfileState {
  final String email, userId, studentId, name, course;
  final List<AttendanceRecord> attendanceRecord;

  ProfileInfoState({
    required this.email,
    required this.userId,
    required this.studentId,
    required this.name,
    required this.course,
    required this.attendanceRecord,
  });
}
