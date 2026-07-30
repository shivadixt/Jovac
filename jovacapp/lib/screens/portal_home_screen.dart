import 'package:flutter/material.dart';
class PortalHomeScreen extends StatelessWidget {
  const PortalHomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _welcomeCard(),
          _quickLinks(),
          Container(
            color: const Color(0xFF4527A0),
            child: const TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white54,
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              tabs: [
                Tab(text: 'Courses'),
                Tab(text: 'Notices'),
                Tab(text: 'Results'),
              ],
            ),
          ),
          const Expanded(
            child: TabBarView(
              children: [
                _CoursesTab(),
                _NoticesTab(),
                _ResultsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _welcomeCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF4527A0), Color(0xFF7B1FA2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome Back 👋', style: TextStyle(color: Colors.white70, fontSize: 13)),
                SizedBox(height: 4),
                Text('Shiva Dixit', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 2),
                Text('B.Tech CSE  |  Roll No: 55', style: TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
          const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white24,
            child: Icon(Icons.person_rounded, size: 38, color: Colors.white),
          ),
        ],
      ),
    );
  }
  Widget _quickLinks() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Quick Links', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF212121))),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _quickLinkItem(Icons.menu_book_rounded, 'Courses', const Color(0xFFFFF3E0), const Color(0xFFE65100))),
              const SizedBox(width: 12),
              Expanded(child: _quickLinkItem(Icons.campaign_rounded, 'Notices', const Color(0xFFE3F2FD), const Color(0xFF1565C0))),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _quickLinkItem(Icons.assignment_rounded, 'Assignments', const Color(0xFFE8F5E9), const Color(0xFF2E7D32))),
              const SizedBox(width: 12),
              Expanded(child: _quickLinkItem(Icons.bar_chart_rounded, 'Results', const Color(0xFFFCE4EC), const Color(0xFFC62828))),
            ],
          ),
        ],
      ),
    );
  }
  Widget _quickLinkItem(IconData icon, String label, Color bg, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
    );
  }
}
class _CoursesTab extends StatelessWidget {
  const _CoursesTab();
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> courses = [
      {'title': 'Flutter Development', 'desc': 'Learn Flutter from Basics', 'instructor': 'Mr. Sharma', 'icon': Icons.flutter_dash, 'color': const Color(0xFF0277BD)},
      {'title': 'Java Programming', 'desc': 'Core Java and OOPs', 'instructor': 'Ms. Joshi', 'icon': Icons.coffee_rounded, 'color': const Color(0xFFBF360C)},
      {'title': 'Python Programming', 'desc': 'Python for Beginners', 'instructor': 'Mr. Verma', 'icon': Icons.code_rounded, 'color': const Color(0xFF2E7D32)},
    ];
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final c = courses[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 3))],
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: (c['color'] as Color).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(c['icon'] as IconData, color: c['color'] as Color, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(c['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 2),
                    Text(c['desc'] as String, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                    const SizedBox(height: 2),
                    Text('Instructor: ${c['instructor']}', style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
class _NoticesTab extends StatelessWidget {
  const _NoticesTab();
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notices = [
      {'title': 'Holiday Tomorrow', 'date': '20 May 2025', 'desc': 'College will remain closed tomorrow on account of Local Holiday.', 'icon': Icons.campaign_rounded, 'color': const Color(0xFFFF6F00)},
      {'title': 'Flutter Assignment Submission', 'date': '18 May 2025', 'desc': 'Submit your Flutter Assignment-13 before 22 May 2025.', 'icon': Icons.description_rounded, 'color': const Color(0xFF1565C0)},
      {'title': 'Mid Semester Exam', 'date': '15 May 2025', 'desc': 'Mid Semester Exams will start from 1st June 2025.', 'icon': Icons.calendar_month_rounded, 'color': const Color(0xFFC62828)},
    ];
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: notices.length,
      itemBuilder: (context, index) {
        final n = notices[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 3))],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: (n['color'] as Color).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(n['icon'] as IconData, color: n['color'] as Color, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(n['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 2),
                    Text(n['date'] as String, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text(n['desc'] as String, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
class _ResultsTab extends StatelessWidget {
  const _ResultsTab();
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> results = [
      {'subject': 'Flutter Development', 'marks': '92 / 100', 'grade': 'A+', 'color': const Color(0xFF2E7D32)},
      {'subject': 'Java Programming', 'marks': '85 / 100', 'grade': 'A', 'color': const Color(0xFF1565C0)},
      {'subject': 'Python Programming', 'marks': '78 / 100', 'grade': 'B+', 'color': const Color(0xFFE65100)},
      {'subject': 'Data Structures', 'marks': '88 / 100', 'grade': 'A', 'color': const Color(0xFF4527A0)},
    ];
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final r = results[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 3))],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(r['subject'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 4),
                    Text(r['marks'] as String, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: (r['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: r['color'] as Color),
                ),
                child: Text(
                  r['grade'] as String,
                  style: TextStyle(color: r['color'] as Color, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
