part of 'profile_cubit.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {
  ProfileInitial();
}

class ProfileInfoState extends ProfileState {
  final String email, id, name, course;

  ProfileInfoState(
      {required this.email,
      required this.id,
      required this.name,
      required this.course});
}
