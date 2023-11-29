part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoginSuccessState extends AuthState {
  final String email, type;
  AuthLoginSuccessState({required this.email, required this.type});
}

class AuthLoginErrorState extends AuthState {
  final String errorMsg;
  AuthLoginErrorState({required this.errorMsg});
}

class LoadingState extends AuthState {
  final bool isLoading;
  LoadingState({required this.isLoading});
}
