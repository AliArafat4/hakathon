class DataInfoModel {
  String? userId, studentId, email, time, name, courseName;
  DataInfoModel(
      {required this.userId,
      required this.studentId,
      required this.email,
      required this.time,
      required this.name,
      required this.courseName});

  DataInfoModel.fromJson(List json) {
    userId = json[0];
    studentId = json[1];
    name = json[2];
    email = json[3];
    courseName = json[4];
    time = json[5];
  }
}
