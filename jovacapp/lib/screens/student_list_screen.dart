import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/student_model.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});
  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  List<StudentModel> _students = [];
  bool _isLoading = true;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshStudentList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _refreshStudentList() async {
    setState(() => _isLoading = true);
    final query = _searchController.text.trim();
    final data = query.isEmpty
        ? await DatabaseHelper.instance.getAllStudents()
        : await DatabaseHelper.instance.searchStudents(query);
    setState(() {
      _students = data;
      _isLoading = false;
    });
  }

  String _getDeptCode(String dept) {
    switch (dept) {
      case 'Computer Science':
        return 'CSE';
      case 'Information Technology':
        return 'IT';
      case 'Electronics':
        return 'ECE';
      case 'Mechanical':
        return 'ME';
      case 'Civil':
        return 'CE';
      default:
        return dept;
    }
  }

  String _getSemShort(String sem) {
    return sem.replaceAll('Semester ', 'Sem ');
  }

  void _showDeleteDialog(StudentModel student) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
            SizedBox(width: 10),
            Text('Delete Student', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Are you sure you want to delete this student record?', style: TextStyle(fontSize: 13, color: Colors.black87)),
            const SizedBox(height: 12),
            Text('Name : ${student.studentName}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 2),
            Text('Roll No : ${student.rollNumber}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          ],
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: Colors.black87)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              if (student.id != null) {
                await DatabaseHelper.instance.deleteStudent(student.id!);
                _refreshStudentList();
              }
              if (ctx.mounted) Navigator.pop(ctx);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Student Record Deleted'), backgroundColor: Colors.red),
                );
              }
            },
            child: const Text('Delete', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FB),
      appBar: AppBar(
        title: const Text('Registered Students', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17)),
        backgroundColor: const Color(0xFF3730A3),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              onChanged: (_) => _refreshStudentList(),
              style: const TextStyle(fontSize: 13),
              decoration: InputDecoration(
                hintText: 'Search by name or roll number...',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                prefixIcon: const Icon(Icons.search_rounded, color: Colors.grey),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          _refreshStudentList();
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
              ),
            ),
            const SizedBox(height: 14),
            Text('Total Students: ${_students.length}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF212121))),
            const SizedBox(height: 12),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator(color: Color(0xFF3730A3)))
                  : _students.isEmpty
                      ? const Center(
                          child: Text('No student records in SQLite database', style: TextStyle(color: Colors.grey, fontSize: 14)),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: DataTable(
                                headingRowColor: WidgetStateProperty.all(const Color(0xFF3730A3)),
                                headingTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                                dataRowMinHeight: 48,
                                dataRowMaxHeight: 52,
                                columns: const [
                                  DataColumn(label: Text('Name')),
                                  DataColumn(label: Text('Roll No')),
                                  DataColumn(label: Text('Dept.')),
                                  DataColumn(label: Text('Sem')),
                                  DataColumn(label: Text('CGPA')),
                                  DataColumn(label: Text('Actions')),
                                ],
                                rows: _students.map((student) {
                                  return DataRow(
                                    cells: [
                                      DataCell(Text(student.studentName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
                                      DataCell(Text(student.rollNumber, style: const TextStyle(fontSize: 12))),
                                      DataCell(Text(_getDeptCode(student.department), style: const TextStyle(fontSize: 12))),
                                      DataCell(Text(_getSemShort(student.semester), style: const TextStyle(fontSize: 12))),
                                      DataCell(Text(student.cgpa.toStringAsFixed(2), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)))),
                                      DataCell(
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.edit_outlined, color: Color(0xFF3730A3), size: 20),
                                              onPressed: () async {
                                                final updated = await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) => EditStudentScreen(student: student),
                                                  ),
                                                );
                                                if (updated == true) {
                                                  _refreshStudentList();
                                                }
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete_outline_rounded, color: Colors.red, size: 20),
                                              onPressed: () => _showDeleteDialog(student),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.swipe_rounded, size: 16, color: Colors.grey),
                  const SizedBox(width: 6),
                  Text('Swipe left or right to see more columns', style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditStudentScreen extends StatefulWidget {
  final StudentModel student;
  const EditStudentScreen({super.key, required this.student});
  @override
  State<EditStudentScreen> createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _rollController;
  late TextEditingController _emailController;
  late TextEditingController _mobileController;
  late TextEditingController _cgpaController;

  late String _selectedDept;
  late String _selectedSem;

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
  void initState() {
    super.initState();
    final s = widget.student;
    _nameController = TextEditingController(text: s.studentName);
    _rollController = TextEditingController(text: s.rollNumber);
    _emailController = TextEditingController(text: s.email);
    _mobileController = TextEditingController(text: s.mobile);
    _cgpaController = TextEditingController(text: s.cgpa.toString());
    _selectedDept = _departments.contains(s.department) ? s.department : 'Computer Science';
    _selectedSem = _semesters.contains(s.semester) ? s.semester : 'Semester 6';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _rollController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _cgpaController.dispose();
    super.dispose();
  }

  void _updateStudent() async {
    if (_formKey.currentState!.validate()) {
      final updatedStudent = StudentModel(
        id: widget.student.id,
        studentName: _nameController.text.trim(),
        rollNumber: _rollController.text.trim(),
        email: _emailController.text.trim(),
        mobile: _mobileController.text.trim(),
        department: _selectedDept,
        semester: _selectedSem,
        cgpa: double.tryParse(_cgpaController.text.trim()) ?? 0.0,
      );

      await DatabaseHelper.instance.updateStudent(updatedStudent);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Student Record Updated in SQLite'), backgroundColor: Color(0xFF2E7D32)),
        );
        Navigator.pop(context, true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FB),
      appBar: AppBar(
        title: const Text('Edit Student', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17)),
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
                    _buildField(_nameController, 'Student Name', Icons.person_outline_rounded, 'Enter name', (v) => (v == null || v.trim().isEmpty) ? 'Please enter name' : null),
                    const SizedBox(height: 12),
                    _buildField(_rollController, 'Roll Number', Icons.badge_outlined, 'Enter roll number', (v) => (v == null || v.trim().isEmpty) ? 'Please enter roll number' : null),
                    const SizedBox(height: 12),
                    _buildField(_emailController, 'Email Address', Icons.email_outlined, 'Enter email', (v) => (v == null || v.trim().isEmpty) ? 'Please enter email' : null, keyboardType: TextInputType.emailAddress),
                    const SizedBox(height: 12),
                    _buildField(_mobileController, 'Mobile Number', Icons.phone_outlined, 'Enter mobile', (v) => (v == null || v.trim().isEmpty) ? 'Please enter mobile' : null, keyboardType: TextInputType.phone),
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
                      onPressed: _updateStudent,
                      icon: const Icon(Icons.save_rounded, color: Colors.white, size: 18),
                      label: const Text('Update Student', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
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
                      onPressed: () => Navigator.pop(context, false),
                      icon: const Icon(Icons.close_rounded, color: Color(0xFF3730A3), size: 18),
                      label: const Text('Cancel', style: TextStyle(color: Color(0xFF3730A3), fontSize: 13, fontWeight: FontWeight.bold)),
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
