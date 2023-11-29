import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_tuwaiq/db/supabase_db.dart';
import 'package:hackathon_tuwaiq/models/attendance_record.dart';
import 'package:hackathon_tuwaiq/models/user_info_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  loadUserInfo() async {
    try {
      final UserInfoModel user = await SupaBaseDB().getCurrentUser();
      final records = await SupaBaseDB()
          .getAttendanceRecord(studentId: "${user.studentId!}");

      final List<AttendanceRecord> record = [];
      for (var item in records) {
        record.add(AttendanceRecord.fromJson(item));
      }

      emit(ProfileInfoState(
          userId: user.userId!,
          studentId: "${user.studentId!}",
          email: user.email!,
          name: user.name!,
          course: user.courseName!,
          attendanceRecord: record));
    } catch (err) {
      print(err);
    }
  }
}
