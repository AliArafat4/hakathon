import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_tuwaiq/bloc/auth_bloc/auth_bloc.dart';
import 'package:hackathon_tuwaiq/bloc/profile_cubit/profile_cubit.dart';
import 'package:hackathon_tuwaiq/bloc/qr_generate_cubit/qr_generator_cubit.dart';
import 'package:hackathon_tuwaiq/db/supabase_db.dart';
import 'package:hackathon_tuwaiq/screens/auth/sign_in_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hackathon_tuwaiq/screens/home_screen.dart';

import 'bloc/qr_scan_cubit/qr_scan_cubit.dart';
import 'shared_prefrences/shared_prefrences.dart';

SharedPref pref = SharedPref();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await pref.initializePref();
  await SupaBaseDB().initializeSupa();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<QrGeneratorCubit>(
          create: (context) => QrGeneratorCubit(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(),
        ),
        BlocProvider<QrScanCubit>(
          create: (context) => QrScanCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: pref.getToken().isEmpty ? SignInScreen() : const HomeScreen(),
      ),
    );
  }
}
