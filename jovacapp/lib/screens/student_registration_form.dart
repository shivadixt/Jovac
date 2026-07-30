import 'package:flutter/material.dart';
class StudentRegistrationForm extends StatefulWidget {
  const StudentRegistrationForm({super.key});
  @override
  State<StudentRegistrationForm> createState() => _StudentRegistrationFormState();
}
class _StudentRegistrationFormState extends State<StudentRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _rollController = TextEditingController();
  final _cityController = TextEditingController();
  String? _selectedCourse;
  final List<String> _courses = [
    'B.Tech Computer Science',
    'B.Tech Information Technology',
    'B.Tech Electronics',
    'BCA',
    'MCA',
    'MBA',
  ];
  void _submit() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          contentPadding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 68,
                height: 68,
                decoration: const BoxDecoration(color: Color(0xFFE8F5E9), shape: BoxShape.circle),
                child: const Icon(Icons.check_rounded, color: Color(0xFF2E7D32), size: 42),
              ),
              const SizedBox(height: 16),
              const Text(
                'Student Registered\nSuccessfully!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
              ),
              const SizedBox(height: 20),
              _dialogRow(Icons.person_rounded, 'Name', _nameController.text),
              _dialogRow(Icons.email_rounded, 'Email', _emailController.text),
              _dialogRow(Icons.phone_rounded, 'Mobile', _mobileController.text),
              _dialogRow(Icons.badge_outlined, 'Roll No', _rollController.text),
              _dialogRow(Icons.menu_book_rounded, 'Course', _selectedCourse ?? ''),
              _dialogRow(Icons.location_on_rounded, 'City', _cityController.text),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3730A3),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('OK', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
  Widget _dialogRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 17, color: const Color(0xFF3730A3)),
          const SizedBox(width: 8),
          SizedBox(
            width: 55,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          ),
          const Text(' : ', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
  void _reset() {
    _formKey.currentState!.reset();
    _nameController.clear();
    _emailController.clear();
    _mobileController.clear();
    _rollController.clear();
    _cityController.clear();
    setState(() => _selectedCourse = null);
  }
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _rollController.dispose();
    _cityController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4FB),
      appBar: AppBar(
        title: const Text('Student Registration', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF3730A3),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3730A3).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.school_rounded, size: 42, color: Color(0xFF3730A3)),
                    ),
                    const SizedBox(height: 12),
                    const Text('Student Registration', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF212121))),
                    const SizedBox(height: 4),
                    Text('Please fill in the details to register', style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    _buildField(
                      controller: _nameController,
                      label: 'Full Name *',
                      icon: Icons.person_outline_rounded,
                      hint: 'Enter your full name',
                      validator: (val) => (val == null || val.trim().isEmpty) ? 'Please enter your full name' : null,
                    ),
                    const SizedBox(height: 16),
                    _buildField(
                      controller: _emailController,
                      label: 'Email Address *',
                      icon: Icons.email_outlined,
                      hint: 'Enter your email address',
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) return 'Please enter your email address';
                        if (!RegExp(r'^[\w.-]+@[\w.-]+\.\w+$').hasMatch(val.trim())) return 'Please enter a valid email address';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildField(
                      controller: _mobileController,
                      label: 'Mobile Number *',
                      icon: Icons.phone_outlined,
                      hint: 'Enter your mobile number',
                      keyboardType: TextInputType.phone,
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) return 'Please enter 10 digit mobile number';
                        if (!RegExp(r'^\d{10}$').hasMatch(val.trim())) return 'Please enter 10 digit mobile number';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildField(
                      controller: _rollController,
                      label: 'Roll Number *',
                      icon: Icons.badge_outlined,
                      hint: 'Enter your roll number',
                      validator: (val) => (val == null || val.trim().isEmpty) ? 'Please enter your roll number' : null,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _selectedCourse,
                      decoration: _inputDecoration('Course *', Icons.menu_book_rounded),
                      hint: Text('Select your course', style: TextStyle(color: Colors.grey.shade400, fontSize: 14)),
                      isExpanded: true,
                      items: _courses
                          .map((c) => DropdownMenuItem<String>(value: c, child: Text(c, style: const TextStyle(fontSize: 14))))
                          .toList(),
                      onChanged: (val) => setState(() => _selectedCourse = val),
                      validator: (val) => val == null ? 'Please select your course' : null,
                    ),
                    const SizedBox(height: 16),
                    _buildField(
                      controller: _cityController,
                      label: 'City *',
                      icon: Icons.location_on_outlined,
                      hint: 'Enter your city',
                      validator: (val) => (val == null || val.trim().isEmpty) ? 'Please enter your city' : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _reset,
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Reset', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF3730A3),
                        side: const BorderSide(color: Color(0xFF3730A3), width: 1.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _submit,
                      icon: const Icon(Icons.send_rounded, color: Colors.white, size: 18),
                      label: const Text('Submit', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3730A3),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 2,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 14, color: Color(0xFF212121)),
      decoration: _inputDecoration(label, icon).copyWith(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
      ),
      validator: validator,
    );
  }
  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(fontSize: 13, color: Color(0xFF3730A3), fontWeight: FontWeight.w500),
      prefixIcon: Icon(icon, color: const Color(0xFF3730A3), size: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF3730A3), width: 2)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.red)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.red, width: 2)),
      errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
    );
  }
}
