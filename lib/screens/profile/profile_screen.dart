import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_tuwaiq/bloc/profile_cubit/profile_cubit.dart';
import 'package:hackathon_tuwaiq/db/supabase_db.dart';
import 'package:hackathon_tuwaiq/main.dart';
import 'package:hackathon_tuwaiq/screens/auth/components/auth_button.dart';
import 'package:hackathon_tuwaiq/screens/auth/sign_in_screen.dart';

import 'components/attendance_record.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              return IconButton(
                  onPressed: () {
                    context.read<ProfileCubit>().loadUserInfo();
                  },
                  icon: const Icon(Icons.refresh));
            },
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const CircleAvatar(
                radius: 40,
                child: Icon(Icons.person, size: 50),
              ),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  state is ProfileInitial
                      ? context.read<ProfileCubit>().loadUserInfo()
                      : const Text("No Record has been Found");
                  return state is ProfileInfoState
                      ? Column(
                          children: [
                            ListTile(
                              leading: const Text("Email"),
                              title: Text(state.email),
                            ),
                            ListTile(
                              leading: const Text("name"),
                              title: Text(state.name),
                            ),
                            ListTile(
                              leading: const Text("course"),
                              title: Text(state.course),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 16.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Attendance Record",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            AttendanceRecordWidget(state: state)
                          ],
                        )
                      : const Center(child: CircularProgressIndicator());
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .02),
              AuthButton(
                  content: "Logout",
                  onPressedFunc: () {
                    pref.cleanToken();
                    SupaBaseDB().signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInScreen(),
                        ),
                        (route) => false);
                  }),
              SizedBox(height: MediaQuery.of(context).size.height * .05),
            ],
          ),
        ),
      ),
    );
  }
}
