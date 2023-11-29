import 'package:flutter/animation.dart';
import 'package:hackathon_tuwaiq/main.dart';
import 'package:hackathon_tuwaiq/models/user_info_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupaBaseDB {
  late final supaBaseInstance;

  initializeSupa() async {
    await Supabase.initialize(
      url: dotenv.env['URL']!,
      anonKey: dotenv.env['KEY']!,
    );
  }

  signOut() async {
    await Supabase.instance.client.auth.signOut();
  }

  login({required String email, required String password}) async {
    try {
      supaBaseInstance = Supabase.instance.client;

      final currentUser = await supaBaseInstance.auth
          .signInWithPassword(email: email, password: password);

      pref.setToken(currentUser.session!.accessToken);
      return "ok";
    } catch (err) {
      return err.toString();
    }
  }

  Future<dynamic> getCurrentUser() async {
    try {
      final client = Supabase.instance.client;
      final studentInfo = await client
          .from("student")
          .select("name, course_id, id")
          .eq('userUid', client.auth.currentUser!.id);

      //TODO: TEST THIS
      // final studentInfo = await client
      //     .from("student")
      //     .select("name, course_id,course(name)!inner")
      //     .eq('userUid', client.auth.currentUser!.id);

      final courseName = await client
          .from("course")
          .select("name")
          .eq('id', studentInfo[0]["course_id"]);

      final userInfo = UserInfoModel.fromJson({
        "user_id": client.auth.currentUser!.id,
        "name": studentInfo[0]["name"],
        "course_name": courseName[0]["name"],
        "email": client.auth.currentUser!.email,
        "time": DateTime.now(),
        "student_id": studentInfo[0]["id"]
      });

      return userInfo;
    } catch (err) {
      print(err);
      return err;
    }
  }

  markStudentAttendance({required userId, required studentId}) async {
    final client = Supabase.instance.client;
    final studentInfo = await client.from("attendance").insert(
      {
        "attendance_date": "${DateTime.now()}",
        "userId": "$userId",
        "student_id": "$studentId",
      },
    ).eq('userId', userId);
  }
}
