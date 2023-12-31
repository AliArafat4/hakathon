part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final String email, password;
  AuthLoginEvent({required this.email, required this.password});
}
