class UserInfoModel {
  String? id;
  String? email;
  DateTime? time;
  String? name;
  String? courseName;

  UserInfoModel({this.id, this.email, this.time, this.name, this.courseName});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
  //   return data;
  // }
}
