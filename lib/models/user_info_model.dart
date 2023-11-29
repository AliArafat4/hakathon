class UserInfoModel {
  String? userId;
  int? studentId;
  String? email;
  DateTime? time;
  String? name;
  String? courseName;

  UserInfoModel(
      {this.userId,
      this.email,
      this.time,
      this.name,
      this.courseName,
      this.studentId});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    studentId = json['student_id'];
    email = json['email'];
    time = json['time'];
    name = json['name'];
    courseName = json['course_name'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['id'] = id;
  //   data['email'] = email;
  //   data['time'] = time;
  //   data['name'] = name;
  //   data['course_name'] = courseName;
  //   return data;
  // }
}
