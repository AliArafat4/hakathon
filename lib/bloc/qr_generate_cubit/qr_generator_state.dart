part of 'qr_generator_cubit.dart';

abstract class QrGeneratorState {}

class QrGeneratorInitial extends QrGeneratorState {}

class GenerateState extends QrGeneratorState {
  final String email, userId, course, name, studentId;
  final DateTime time;

  GenerateState({
    required this.email,
    required this.userId,
    required this.time,
    required this.course,
    required this.name,
    required this.studentId,
  });
}

class QrLoadingState extends QrGeneratorState {
  final bool isLoading;

  QrLoadingState({required this.isLoading});
}
