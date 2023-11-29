class AttendanceRecord {
  int? id;
  int? studentId;
  String? userId;
  String? attendanceDate;

  AttendanceRecord({this.id, this.studentId, this.userId, this.attendanceDate});

  AttendanceRecord.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    userId = json['userId'];
    attendanceDate = json['attendance_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['student_id'] = studentId;
    data['userId'] = userId;
    data['attendance_date'] = attendanceDate;
    return data;
  }
}
