import 'package:bloc/bloc.dart';
import 'package:hackathon_tuwaiq/db/supabase_db.dart';
import 'package:hackathon_tuwaiq/models/user_info_model.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  loadUserInfo() async {
    final UserInfoModel user = await SupaBaseDB().getCurrentUser();
    emit(ProfileInfoState(
        id: user.userId!,
        email: user.email!,
        name: user.name!,
        course: user.courseName!));
  }
}
