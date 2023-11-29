import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_tuwaiq/bloc/auth_bloc/auth_bloc.dart';
import 'package:hackathon_tuwaiq/screens/auth/components/auth_button.dart';
import 'package:hackathon_tuwaiq/screens/auth/components/auth_loading.dart';
import 'package:hackathon_tuwaiq/screens/auth/components/auth_text_field.dart';
import 'package:hackathon_tuwaiq/screens/home_screen.dart';
import 'package:hackathon_tuwaiq/screens/qr_scanner_screen.dart';

import 'components/show_snack_bar.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * .1),
          GestureDetector(
            child: Image.asset(
              "assets/images/tuwaiq_logo_no_bg.png",
              scale: 2,
            ),
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QrScannerScreen(),
                  ));
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .065),
          AuthTextField(
            isPassword: false,
            controller: emailController,
            content: "Email",
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .02),
          AuthTextField(
            isPassword: true,
            controller: passwordController,
            content: "Password",
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .03),
          BlocConsumer<AuthBloc, AuthState>(
            builder: (context, state) {
              return AuthButton(
                  content: "Sign In",
                  onPressedFunc: () {
                    context.read<AuthBloc>().add(
                          AuthLoginEvent(
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        );
                  });
            },
            listener: (BuildContext context, AuthState state) {
              state is LoadingState ? showLoadingIndicator() : const SizedBox();
              state is AuthLoginErrorState
                  ? showSnackBar(context: context, message: state.errorMsg)
                  : const SizedBox();
              state is AuthLoginSuccessState
                  ? Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                      (route) => false,
                    )
                  : const SizedBox();
            },
          ),
          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.only(right: 16.0, top: 8),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Are You an Admin?",
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                  ),
                ),
              ),
            ),
            onTap: () {
              //TODO:
            },
          )
        ],
      ),
    );
  }
}
