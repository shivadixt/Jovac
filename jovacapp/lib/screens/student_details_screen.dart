import 'package:flutter/material.dart';

class StudentDetailsScreen extends StatefulWidget {
  final String studentName;
  final String rollNumber;
  final String course;
  const StudentDetailsScreen({
    super.key,
    required this.studentName,
    required this.rollNumber,
    required this.course,
  });
  @override
  State<StudentDetailsScreen> createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  late String _currentCourse;
  @override
  void initState() {
    super.initState();
    _currentCourse = widget.course;
  }

  void _navigateToEditCourse() async {
    final updatedCourse = await Navigator.pushNamed(
      context,
      '/editCourse',
      arguments: _currentCourse,
    );
    if (updatedCourse != null && updatedCourse is String) {
      setState(() {
        _currentCourse = updatedCourse;
      });
    }
  }

  void _goBack() {
    Navigator.pop(context, _currentCourse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F8E9),
      appBar: AppBar(
        title: const Text(
          'Student Details',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: _goBack,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.12),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Student Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),
                  _buildDetailRow(
                    icon: Icons.person_rounded,
                    iconColor: const Color(0xFF5C6BC0),
                    label: 'Name',
                    value: widget.studentName,
                  ),
                  const SizedBox(height: 20),
                  _buildDetailRow(
                    icon: Icons.badge_outlined,
                    iconColor: const Color(0xFFE65100),
                    label: 'Roll No',
                    value: widget.rollNumber,
                  ),
                  const SizedBox(height: 20),
                  _buildDetailRow(
                    icon: Icons.school_rounded,
                    iconColor: const Color(0xFF1565C0),
                    label: 'Course',
                    value: _currentCourse,
                    valueColor: const Color(0xFF1565C0),
                    isBold: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                onPressed: _navigateToEditCourse,
                icon: const Icon(Icons.edit_rounded, color: Colors.white),
                label: const Text(
                  'Edit Course',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6A1B9A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 4,
                ),
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 52,
              child: OutlinedButton.icon(
                onPressed: _goBack,
                icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF37474F)),
                label: const Text(
                  'Go Back',
                  style: TextStyle(
                    color: Color(0xFF37474F),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF90A4AE), width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade100),
              ),
              child: const Text(
                'Click "Edit Course" to change course (Navigator.pushNamed)\n'
                'Click "Go Back" to return with data (Navigator.pop)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF558B2F),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    Color valueColor = const Color(0xFF212121),
    bool isBold = false,
  }) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 26),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF9E9E9E),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                color: valueColor,
                fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
