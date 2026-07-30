class StudentModel {
  final int? id;
  final String studentName;
  final String rollNumber;
  final String email;
  final String mobile;
  final String department;
  final String semester;
  final double cgpa;

  StudentModel({
    this.id,
    required this.studentName,
    required this.rollNumber,
    required this.email,
    required this.mobile,
    required this.department,
    required this.semester,
    required this.cgpa,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'studentName': studentName,
      'rollNumber': rollNumber,
      'email': email,
      'mobile': mobile,
      'department': department,
      'semester': semester,
      'cgpa': cgpa,
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      id: map['id'] as int?,
      studentName: map['studentName'] as String? ?? '',
      rollNumber: map['rollNumber'] as String? ?? '',
      email: map['email'] as String? ?? '',
      mobile: map['mobile'] as String? ?? '',
      department: map['department'] as String? ?? '',
      semester: map['semester'] as String? ?? '',
      cgpa: (map['cgpa'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
