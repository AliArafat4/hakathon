part of 'qr_generator_cubit.dart';

abstract class QrGeneratorState {}

class QrGeneratorInitial extends QrGeneratorState {}

class GenerateState extends QrGeneratorState {
  final String email, id, course, name;
  final DateTime time;

  GenerateState({
    required this.email,
    required this.id,
    required this.time,
    required this.course,
    required this.name,
  });
}

class QrLoadingState extends QrGeneratorState {
  final bool isLoading;

  QrLoadingState({required this.isLoading});
}
