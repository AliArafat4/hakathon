import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_tuwaiq/bloc/profile_cubit/profile_cubit.dart';
import 'package:hackathon_tuwaiq/db/supabase_db.dart';
import 'package:hackathon_tuwaiq/main.dart';
import 'package:hackathon_tuwaiq/screens/auth/components/auth_button.dart';
import 'package:hackathon_tuwaiq/screens/auth/sign_in_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              child: Icon(Icons.person, size: 50),
            ),
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                state is ProfileInitial
                    ? context.read<ProfileCubit>().loadUserInfo()
                    : const SizedBox();
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
                        ],
                      )
                    : const SizedBox();
              },
            ),
            const Spacer(),
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
                })
          ],
        ),
      ),
    );
  }
}
