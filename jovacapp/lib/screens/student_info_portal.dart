import 'package:flutter/material.dart';
class StudentInfoPortalScreen extends StatefulWidget {
  const StudentInfoPortalScreen({super.key});
  @override
  State<StudentInfoPortalScreen> createState() => _StudentInfoPortalScreenState();
}
class _StudentInfoPortalScreenState extends State<StudentInfoPortalScreen> {
  int _currentNavIndex = 0;
  final Map<String, String> _studentDetails = {
    'Student Name': 'Shiva Dixit',
    'Email': 'shiva@gmail.com',
    'Mobile': '+91 9876543210',
    'Roll Number': '2415001486',
    'College Website': 'www.fluttercollege.com',
  };
  final List<Map<String, dynamic>> _marksheetData = [
    {'subject': 'Mathematics', 'maxMarks': 100, 'obtained': 95},
    {'subject': 'Science', 'maxMarks': 100, 'obtained': 90},
    {'subject': 'English', 'maxMarks': 100, 'obtained': 88},
    {'subject': 'Computer', 'maxMarks': 100, 'obtained': 98},
    {'subject': 'Hindi', 'maxMarks': 100, 'obtained': 85},
  ];
  int get _totalObtained => _marksheetData.fold(0, (sum, item) => sum + (item['obtained'] as int));
  int get _totalMax => _marksheetData.fold(0, (sum, item) => sum + (item['maxMarks'] as int));
  double get _percentage => (_totalObtained / _totalMax) * 100;
  String get _grade {
    if (_percentage >= 90) return 'A+';
    if (_percentage >= 80) return 'A';
    if (_percentage >= 70) return 'B';
    if (_percentage >= 60) return 'C';
    return 'D';
  }
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(child: Text(message, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500))),
          ],
        ),
        backgroundColor: const Color(0xFF2E7D32),
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        action: SnackBarAction(
          label: 'UNDO',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }
  void _openBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Student Actions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF4A148C)),
              ),
              const SizedBox(height: 12),
              _actionTile(Icons.email_rounded, 'Send Email', Colors.blue, () {
                Navigator.pop(ctx);
                _showSnackBar('Email sent to student successfully!');
              }),
              _actionTile(Icons.phone_rounded, 'Call Student', Colors.green, () {
                Navigator.pop(ctx);
                _showSnackBar('Call initiated to student!');
              }),
              _actionTile(Icons.location_on_rounded, 'View Address', Colors.orange, () {
                Navigator.pop(ctx);
                _showSnackBar('Student address retrieved!');
              }),
              _actionTile(Icons.share_rounded, 'Share Profile', Colors.purple, () {
                Navigator.pop(ctx);
                _showSnackBar('Student Profile Shared Successfully!');
              }),
              _actionTile(Icons.download_rounded, 'Download Marksheet', Colors.indigo, () {
                Navigator.pop(ctx);
                _showSnackBar('Marksheet Downloaded Successfully!');
              }),
              _actionTile(Icons.cancel_rounded, 'Close', Colors.red, () {
                Navigator.pop(ctx);
              }),
            ],
          ),
        );
      },
    );
  }
  Widget _actionTile(IconData icon, String title, Color color, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
      onTap: onTap,
      dense: true,
      contentPadding: EdgeInsets.zero,
    );
  }
  IconData _getFieldIcon(String key) {
    switch (key) {
      case 'Student Name':
        return Icons.person_rounded;
      case 'Email':
        return Icons.email_rounded;
      case 'Mobile':
        return Icons.phone_rounded;
      case 'Roll Number':
        return Icons.badge_rounded;
      case 'College Website':
        return Icons.language_rounded;
      default:
        return Icons.info_rounded;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E5F5),
      appBar: AppBar(
        title: const Text('Student Information Portal', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        leading: const Icon(Icons.school_rounded, color: Colors.white),
        backgroundColor: const Color(0xFF4A148C),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
            onPressed: () {},
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.account_circle_rounded, color: Color(0xFF4A148C), size: 28),
                        SizedBox(width: 10),
                        Text('Student Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF4A148C))),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ..._studentDetails.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Icon(_getFieldIcon(entry.key), size: 18, color: Colors.grey.shade700),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 110,
                              child: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                            ),
                            Expanded(
                              child: SelectableText(
                                entry.value,
                                style: const TextStyle(color: Color(0xFF1565C0), fontWeight: FontWeight.w600, fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.grid_on_rounded, color: Color(0xFF4A148C), size: 26),
                        SizedBox(width: 10),
                        Text('Student Marksheet', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF4A148C))),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Table(
                      border: TableBorder.all(color: Colors.purple.shade100, width: 1, borderRadius: BorderRadius.circular(6)),
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(1),
                      },
                      children: [
                        TableRow(
                          decoration: const BoxDecoration(color: Color(0xFF4A148C)),
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text('Subject', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text('Max Marks', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text('Obtained', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                            ),
                          ],
                        ),
                        ..._marksheetData.map((item) {
                          return TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                child: Text(item['subject'].toString(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Text(item['maxMarks'].toString(), textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  item['obtained'].toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _summaryCard(Icons.assignment_turned_in_rounded, 'Total Marks', '$_totalObtained / $_totalMax', Colors.purple),
                        _summaryCard(Icons.percent_rounded, 'Percentage', '${_percentage.toStringAsFixed(1)}%', Colors.blue),
                        _summaryCard(Icons.star_rounded, 'Grade', _grade, Colors.amber.shade800),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: _openBottomSheet,
                icon: const Icon(Icons.list_alt_rounded, color: Colors.white),
                label: const Text('Show Student Actions', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A148C),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentNavIndex,
        onTap: (index) => setState(() => _currentNavIndex = index),
        selectedItemColor: const Color(0xFF4A148C),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_rounded), label: 'Settings'),
        ],
      ),
    );
  }
  Widget _summaryCard(IconData icon, String label, String value, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 11, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
        const SizedBox(height: 2),
        Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }
}
