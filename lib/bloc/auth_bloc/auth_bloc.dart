import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_tuwaiq/db/supabase_db.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginEvent>((event, emit) async {
      emit(LoadingState(isLoading: true));
      if (event.email.isNotEmpty && event.password.isNotEmpty) {
        final response = await SupaBaseDB()
            .login(email: event.email.trim(), password: event.password.trim());

        if (event.email.trim().isEmpty) {
          emit(AuthLoginErrorState(errorMsg: "Please Enter Your Email"));
          emit(LoadingState(isLoading: false));
        } else if (event.password.isEmpty) {
          emit(LoadingState(isLoading: false));
          emit(AuthLoginErrorState(errorMsg: "Please Enter Your Password"));
        } else if (response.toString().toLowerCase() == "ok") {
          emit(LoadingState(isLoading: false));
          emit(AuthLoginSuccessState(type: "login", email: event.email.trim()));
        } else {
          emit(LoadingState(isLoading: false));
          emit(
              AuthLoginErrorState(errorMsg: "Email or Password are incorrect"));
        }
      } else {
        emit(AuthLoginErrorState(errorMsg: 'Please Fill The Required Fields'));
      }
    });
  }
}
