import 'package:flutter/material.dart';

class EditCourseScreen extends StatefulWidget {
  final String initialCourse;
  const EditCourseScreen({super.key, required this.initialCourse});
  @override
  State<EditCourseScreen> createState() => _EditCourseScreenState();
}

class _EditCourseScreenState extends State<EditCourseScreen> {
  final List<String> _courses = ['Flutter', 'Java', 'Python', 'AI'];
  late String _selectedCourse;
  @override
  void initState() {
    super.initState();
    _selectedCourse = widget.initialCourse;
  }

  void _saveChanges() {
    Navigator.pop(context, _selectedCourse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      appBar: AppBar(
        title: const Text(
          'Edit Course',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE65100), Color(0xFFFF9800)],
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
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.12),
                    blurRadius: 14,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Icon(Icons.menu_book_rounded, color: Color(0xFFE65100), size: 28),
                  SizedBox(width: 12),
                  Text(
                    'Select New Course',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE65100),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.08),
                    blurRadius: 14,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: _courses.map((course) {
                  final isSelected = _selectedCourse == course;
                  return InkWell(
                    onTap: () => setState(() => _selectedCourse = course),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFFF9800).withOpacity(0.12)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? const Color(0xFFFF9800) : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Radio<String>(
                            value: course,
                            groupValue: _selectedCourse,
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => _selectedCourse = val);
                              }
                            },
                            activeColor: const Color(0xFFE65100),
                          ),
                          const SizedBox(width: 8),
                          _buildCourseIcon(course),
                          const SizedBox(width: 12),
                          Text(
                            course,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              color: isSelected
                                  ? const Color(0xFFE65100)
                                  : const Color(0xFF37474F),
                            ),
                          ),
                          const Spacer(),
                          if (isSelected)
                            const Icon(Icons.check_circle_rounded,
                                color: Color(0xFFE65100), size: 20),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 54,
              child: ElevatedButton.icon(
                onPressed: _saveChanges,
                icon: const Icon(Icons.check_rounded, color: Colors.white, size: 22),
                label: const Text(
                  'Save Changes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE65100),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 4,
                ),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.shade100),
              ),
              child: const Text(
                'Select new course and click "Save Changes"\n(Navigator.pop with data)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFFE65100),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseIcon(String course) {
    IconData icon;
    Color color;
    switch (course) {
      case 'Flutter':
        icon = Icons.flutter_dash;
        color = const Color(0xFF0277BD);
        break;
      case 'Java':
        icon = Icons.coffee_rounded;
        color = const Color(0xFFB71C1C);
        break;
      case 'Python':
        icon = Icons.code_rounded;
        color = const Color(0xFF2E7D32);
        break;
      case 'AI':
        icon = Icons.smart_toy_rounded;
        color = const Color(0xFF6A1B9A);
        break;
      default:
        icon = Icons.book_rounded;
        color = Colors.grey;
    }
    return Icon(icon, color: color, size: 22);
  }
}
