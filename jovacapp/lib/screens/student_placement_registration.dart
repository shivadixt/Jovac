import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentPlacementRegistrationScreen extends StatefulWidget {
  const StudentPlacementRegistrationScreen({super.key});
  @override
  State<StudentPlacementRegistrationScreen> createState() => _StudentPlacementRegistrationScreenState();
}

class _StudentPlacementRegistrationScreenState extends State<StudentPlacementRegistrationScreen> {
  bool _isLoading = true;
  bool _hasSavedData = false;
  Map<String, dynamic>? _savedStudentData;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('student_name');
    final rollNo = prefs.getString('student_roll');
    final email = prefs.getString('student_email');
    final mobile = prefs.getString('student_mobile');
    final branch = prefs.getString('student_branch');
    final cgpa = prefs.getDouble('student_cgpa');
    final isInterested = prefs.getBool('student_interested');

    if (name != null && name.isNotEmpty) {
      setState(() {
        _hasSavedData = true;
        _savedStudentData = {
          'name': name,
          'rollNo': rollNo ?? '',
          'email': email ?? '',
          'mobile': mobile ?? '',
          'branch': branch ?? 'Computer Science',
          'cgpa': cgpa ?? 0.0,
          'isInterested': isInterested ?? true,
        };
        _isLoading = false;
      });
    } else {
      setState(() {
        _hasSavedData = false;
        _savedStudentData = null;
        _isLoading = false;
      });
    }
  }

  Future<void> _saveData(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('student_name', data['name']);
    await prefs.setString('student_roll', data['rollNo']);
    await prefs.setString('student_email', data['email']);
    await prefs.setString('student_mobile', data['mobile']);
    await prefs.setString('student_branch', data['branch']);
    await prefs.setDouble('student_cgpa', data['cgpa']);
    await prefs.setBool('student_interested', data['isInterested']);
    await _loadSavedData();
  }

  Future<void> _deleteData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('student_name');
    await prefs.remove('student_roll');
    await prefs.remove('student_email');
    await prefs.remove('student_mobile');
    await prefs.remove('student_branch');
    await prefs.remove('student_cgpa');
    await prefs.remove('student_interested');
    setState(() {
      _hasSavedData = false;
      _savedStudentData = null;
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Placement Details Deleted Successfully'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: Color(0xFF4527A0))),
      );
    }

    if (_hasSavedData && _savedStudentData != null) {
      return _PlacementDashboardView(
        data: _savedStudentData!,
        onEdit: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => _RegistrationFormView(
                initialData: _savedStudentData,
                isEditMode: true,
                onSave: _saveData,
              ),
            ),
          );
          if (result == true) {
            _loadSavedData();
          }
        },
        onDelete: _deleteData,
      );
    }

    return _RegistrationFormView(
      initialData: null,
      isEditMode: false,
      onSave: _saveData,
    );
  }
}

class _RegistrationFormView extends StatefulWidget {
  final Map<String, dynamic>? initialData;
  final bool isEditMode;
  final Future<void> Function(Map<String, dynamic> data) onSave;

  const _RegistrationFormView({
    required this.initialData,
    required this.isEditMode,
    required this.onSave,
  });

  @override
  State<_RegistrationFormView> createState() => _RegistrationFormViewState();
}

class _RegistrationFormViewState extends State<_RegistrationFormView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _rollController;
  late TextEditingController _emailController;
  late TextEditingController _mobileController;
  late TextEditingController _cgpaController;
  String _selectedBranch = 'Computer Science';
  bool _isInterested = true;
  bool _showSavedSuccessBanner = false;

  final List<String> _branches = [
    'Computer Science',
    'Information Technology',
    'Electronics',
    'Mechanical',
    'Civil',
  ];

  @override
  void initState() {
    super.initState();
    final d = widget.initialData;
    _nameController = TextEditingController(text: d != null ? d['name'] : '');
    _rollController = TextEditingController(text: d != null ? d['rollNo'] : '');
    _emailController = TextEditingController(text: d != null ? d['email'] : '');
    _mobileController = TextEditingController(text: d != null ? d['mobile'] : '');
    _cgpaController = TextEditingController(text: d != null ? d['cgpa'].toString() : '');
    if (d != null && _branches.contains(d['branch'])) {
      _selectedBranch = d['branch'];
    }
    if (d != null) {
      _isInterested = d['isInterested'] ?? true;
    }
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

  void _clearForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _rollController.clear();
    _emailController.clear();
    _mobileController.clear();
    _cgpaController.clear();
    setState(() {
      _selectedBranch = 'Computer Science';
      _isInterested = true;
      _showSavedSuccessBanner = false;
    });
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final data = {
        'name': _nameController.text.trim(),
        'rollNo': _rollController.text.trim(),
        'email': _emailController.text.trim(),
        'mobile': _mobileController.text.trim(),
        'branch': _selectedBranch,
        'cgpa': double.tryParse(_cgpaController.text.trim()) ?? 0.0,
        'isInterested': _isInterested,
      };

      setState(() => _showSavedSuccessBanner = true);
      await widget.onSave(data);

      if (widget.isEditMode && mounted) {
        Future.delayed(const Duration(milliseconds: 600), () {
          if (mounted) Navigator.pop(context, true);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FB),
      appBar: AppBar(
        title: const Text('Student Placement Registration', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17)),
        backgroundColor: const Color(0xFF4527A0),
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: widget.isEditMode,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.school_rounded, size: 60, color: Color(0xFF4527A0)),
                    SizedBox(width: 20),
                    Icon(Icons.assignment_turned_in_rounded, size: 55, color: Color(0xFF7B1FA2)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    const Text('Register Your Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF4527A0))),
                    const SizedBox(height: 16),
                    _buildTextField(_nameController, 'Student Name', Icons.person_outline_rounded, 'Enter full name', (v) => (v == null || v.trim().isEmpty) ? 'Please enter student name' : null),
                    const SizedBox(height: 12),
                    _buildTextField(_rollController, 'Roll Number', Icons.badge_outlined, 'Enter roll number', (v) => (v == null || v.trim().isEmpty) ? 'Please enter roll number' : null),
                    const SizedBox(height: 12),
                    _buildTextField(_emailController, 'Email', Icons.email_outlined, 'Enter email address', (v) => (v == null || v.trim().isEmpty) ? 'Please enter email' : null, keyboardType: TextInputType.emailAddress),
                    const SizedBox(height: 12),
                    _buildTextField(_mobileController, 'Mobile Number', Icons.phone_outlined, 'Enter mobile number', (v) => (v == null || v.trim().isEmpty) ? 'Please enter mobile number' : null, keyboardType: TextInputType.phone),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _selectedBranch,
                      decoration: _inputDecoration('Branch', Icons.domain_rounded),
                      items: _branches.map((b) => DropdownMenuItem(value: b, child: Text(b, style: const TextStyle(fontSize: 13)))).toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedBranch = val);
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(_cgpaController, 'CGPA', Icons.bar_chart_rounded, 'Enter CGPA (e.g. 8.75)', (v) {
                      if (v == null || v.trim().isEmpty) return 'Please enter CGPA';
                      final parsed = double.tryParse(v.trim());
                      if (parsed == null || parsed < 0.0 || parsed > 10.0) return 'Enter valid CGPA (0-10)';
                      return null;
                    }, keyboardType: const TextInputType.numberWithOptions(decimal: true)),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade300)),
                      child: Row(
                        children: [
                          const Icon(Icons.person_rounded, color: Color(0xFF4527A0), size: 20),
                          const SizedBox(width: 10),
                          const Expanded(child: Text('Interested in Placement', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500))),
                          Switch(
                            value: _isInterested,
                            activeColor: const Color(0xFF4527A0),
                            onChanged: (val) => setState(() => _isInterested = val),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _submitForm,
                      icon: const Icon(Icons.save_rounded, color: Colors.white, size: 18),
                      label: const Text('SAVE DETAILS', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4527A0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _clearForm,
                      icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFF4527A0), size: 18),
                      label: const Text('CLEAR FORM', style: TextStyle(color: Color(0xFF4527A0), fontSize: 13, fontWeight: FontWeight.bold)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF4527A0), width: 1.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
              if (_showSavedSuccessBanner) ...[
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFF2E7D32)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.check_circle_rounded, color: Color(0xFF2E7D32), size: 22),
                      SizedBox(width: 10),
                      Text('Registration Saved Successfully!', style: TextStyle(color: Color(0xFF2E7D32), fontWeight: FontWeight.bold, fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
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
      labelStyle: const TextStyle(fontSize: 12, color: Color(0xFF4527A0), fontWeight: FontWeight.w500),
      prefixIcon: Icon(icon, color: const Color(0xFF4527A0), size: 18),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF4527A0), width: 2)),
    );
  }
}

class _PlacementDashboardView extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _PlacementDashboardView({
    required this.data,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isInterested = data['isInterested'] as bool? ?? true;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FB),
      appBar: AppBar(
        title: const Text('Placement Dashboard', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17)),
        backgroundColor: const Color(0xFF4527A0),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFA5D6A7)),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: Color(0xFF2E7D32),
                    child: Icon(Icons.person_rounded, color: Colors.white, size: 30),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Welcome, ${data['name']}!', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF1B5E20))),
                        const SizedBox(height: 2),
                        const Text('Your placement details are saved.', style: TextStyle(fontSize: 12, color: Color(0xFF2E7D32))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  _infoRow(Icons.person_rounded, 'Student Name', data['name']),
                  const Divider(height: 16),
                  _infoRow(Icons.badge_rounded, 'Roll Number', data['rollNo']),
                  const Divider(height: 16),
                  _infoRow(Icons.email_rounded, 'Email', data['email']),
                  const Divider(height: 16),
                  _infoRow(Icons.phone_rounded, 'Mobile Number', data['mobile']),
                  const Divider(height: 16),
                  _infoRow(Icons.domain_rounded, 'Branch', data['branch']),
                  const Divider(height: 16),
                  _infoRow(Icons.bar_chart_rounded, 'CGPA', data['cgpa'].toString()),
                  const Divider(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.military_tech_rounded, color: Color(0xFF4527A0), size: 20),
                      const SizedBox(width: 12),
                      const SizedBox(width: 110, child: Text('Placement Status', style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w500))),
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              isInterested ? Icons.check_circle_rounded : Icons.cancel_rounded,
                              color: isInterested ? const Color(0xFF2E7D32) : Colors.red,
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              isInterested ? 'Interested' : 'Not Interested',
                              style: TextStyle(
                                color: isInterested ? const Color(0xFF2E7D32) : Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: onEdit,
                icon: const Icon(Icons.edit_rounded, color: Colors.white, size: 18),
                label: const Text('EDIT DETAILS', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1565C0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: onDelete,
                icon: const Icon(Icons.delete_rounded, color: Colors.white, size: 18),
                label: const Text('DELETE DETAILS', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC62828),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF4527A0), size: 20),
        const SizedBox(width: 12),
        SizedBox(width: 110, child: Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.w500))),
        Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF212121)), textAlign: TextAlign.right)),
      ],
    );
  }
}
