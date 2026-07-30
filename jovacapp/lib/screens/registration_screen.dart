import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/student_model.dart';
import 'student_list_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _rollController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _cgpaController = TextEditingController();

  String _selectedDept = 'Computer Science';
  String _selectedSem = 'Semester 6';

  final List<String> _departments = [
    'Computer Science',
    'Information Technology',
    'Electronics',
    'Mechanical',
    'Civil',
  ];

  final List<String> _semesters = [
    'Semester 1',
    'Semester 2',
    'Semester 3',
    'Semester 4',
    'Semester 5',
    'Semester 6',
    'Semester 7',
    'Semester 8',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _rollController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _cgpaController.dispose();
    super.dispose();
  }

  void _clearForm() {
    _nameController.clear();
    _rollController.clear();
    _emailController.clear();
    _mobileController.clear();
    _cgpaController.clear();
    setState(() {
      _selectedDept = 'Computer Science';
      _selectedSem = 'Semester 6';
    });
  }

  void _registerStudent() async {
    if (_formKey.currentState!.validate()) {
      final student = StudentModel(
        studentName: _nameController.text.trim(),
        rollNumber: _rollController.text.trim(),
        email: _emailController.text.trim(),
        mobile: _mobileController.text.trim(),
        department: _selectedDept,
        semester: _selectedSem,
        cgpa: double.tryParse(_cgpaController.text.trim()) ?? 0.0,
      );

      final id = await DatabaseHelper.instance.insertStudent(student);
      final savedStudent = StudentModel(
        id: id,
        studentName: student.studentName,
        rollNumber: student.rollNumber,
        email: student.email,
        mobile: student.mobile,
        department: student.department,
        semester: student.semester,
        cgpa: student.cgpa,
      );

      if (mounted) {
        _clearForm();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => StudentRegisteredSuccessScreen(student: savedStudent),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FB),
      appBar: AppBar(
        title: const Text('Student Registration', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17)),
        backgroundColor: const Color(0xFF3730A3),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
                child: Column(
                  children: [
                    _buildField(_nameController, 'Student Name', Icons.person_outline_rounded, 'Enter student name', (v) => (v == null || v.trim().isEmpty) ? 'Please enter student name' : null),
                    const SizedBox(height: 12),
                    _buildField(_rollController, 'Roll Number', Icons.badge_outlined, 'Enter roll number', (v) => (v == null || v.trim().isEmpty) ? 'Please enter roll number' : null),
                    const SizedBox(height: 12),
                    _buildField(_emailController, 'Email Address', Icons.email_outlined, 'Enter email address', (v) => (v == null || v.trim().isEmpty) ? 'Please enter email address' : null, keyboardType: TextInputType.emailAddress),
                    const SizedBox(height: 12),
                    _buildField(_mobileController, 'Mobile Number', Icons.phone_outlined, 'Enter mobile number', (v) => (v == null || v.trim().isEmpty) ? 'Please enter mobile number' : null, keyboardType: TextInputType.phone),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _selectedDept,
                      decoration: _inputDecoration('Department', Icons.domain_rounded),
                      items: _departments.map((d) => DropdownMenuItem(value: d, child: Text(d, style: const TextStyle(fontSize: 13)))).toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedDept = val);
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _selectedSem,
                      decoration: _inputDecoration('Semester', Icons.calendar_month_rounded),
                      items: _semesters.map((s) => DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(fontSize: 13)))).toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedSem = val);
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildField(_cgpaController, 'CGPA', Icons.bar_chart_rounded, 'Enter CGPA', (v) {
                      if (v == null || v.trim().isEmpty) return 'Please enter CGPA';
                      final val = double.tryParse(v.trim());
                      if (val == null || val < 0 || val > 10) return 'Enter valid CGPA (0-10)';
                      return null;
                    }, keyboardType: const TextInputType.numberWithOptions(decimal: true)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _registerStudent,
                      icon: const Icon(Icons.person_add_rounded, color: Colors.white, size: 18),
                      label: const Text('Register Student', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3730A3),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const StudentListScreen()),
                        );
                      },
                      icon: const Icon(Icons.list_alt_rounded, color: Color(0xFF3730A3), size: 18),
                      label: const Text('View Students', style: TextStyle(color: Color(0xFF3730A3), fontSize: 13, fontWeight: FontWeight.bold)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF3730A3), width: 1.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    TextEditingController controller,
    String label,
    IconData icon,
    String hint,
    String? Function(String?) validator, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 13),
      decoration: _inputDecoration(label, icon).copyWith(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
      ),
      validator: validator,
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(fontSize: 12, color: Color(0xFF3730A3), fontWeight: FontWeight.w500),
      prefixIcon: Icon(icon, color: const Color(0xFF3730A3), size: 18),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF3730A3), width: 2)),
    );
  }
}

class StudentRegisteredSuccessScreen extends StatelessWidget {
  final StudentModel student;
  const StudentRegisteredSuccessScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(color: Color(0xFFE8F5E9), shape: BoxShape.circle),
                child: const Icon(Icons.check_circle_rounded, color: Color(0xFF2E7D32), size: 64),
              ),
              const SizedBox(height: 16),
              const Text('Student Registered\nSuccessfully!', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: const Color(0xFFE8F5E9).withOpacity(0.6), borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.green.shade200)),
                child: Column(
                  children: [
                    _row('Name', student.studentName),
                    _row('Roll No', student.rollNumber),
                    _row('Department', student.department),
                    _row('Semester', student.semester),
                    _row('CGPA', student.cgpa.toStringAsFixed(2)),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const StudentListScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3730A3), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  child: const Text('View All Students', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Add Another Student', style: TextStyle(color: Color(0xFF3730A3), fontWeight: FontWeight.bold, fontSize: 14)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(String label, String val) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
          const Text(' :  ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(val, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}
