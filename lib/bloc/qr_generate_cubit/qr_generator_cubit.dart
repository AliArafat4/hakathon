import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon_tuwaiq/db/supabase_db.dart';
import 'package:hackathon_tuwaiq/models/user_info_model.dart';

part 'qr_generator_state.dart';

class QrGeneratorCubit extends Cubit<QrGeneratorState> {
  QrGeneratorCubit() : super(QrGeneratorInitial());

  generateQrEvent() async {
    emit(QrLoadingState(isLoading: true));
    final UserInfoModel info = await SupaBaseDB().getCurrentUser();
    emit(QrLoadingState(isLoading: false));
    emit(GenerateState(
      email: info.email!,
      userId: info.userId!,
      studentId: "${info.studentId!}",
      time: info.time!,
      course: info.courseName!,
      name: info.name!,
    ));
  }
}
