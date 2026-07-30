import 'package:flutter/material.dart';
import 'portal_home_screen.dart';
import 'portal_attendance_screen.dart';
import 'portal_assignments_screen.dart';
import 'portal_profile_screen.dart';
class CollegePortalScreen extends StatefulWidget {
  const CollegePortalScreen({super.key});
  @override
  State<CollegePortalScreen> createState() => _CollegePortalScreenState();
}
class _CollegePortalScreenState extends State<CollegePortalScreen> {
  int _selectedIndex = 0;
  final List<String> _titles = [
    'College Student Portal',
    'My Attendance',
    'My Assignments',
    'My Profile',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4527A0), Color(0xFF7B1FA2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4527A0), Color(0xFF7B1FA2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              accountName: const Text(
                'Shiva Dixit',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              accountEmail: const Text('B.Tech CSE  |  Roll No: 55'),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person_rounded, size: 40, color: Color(0xFF4527A0)),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                children: [
                  _buildDrawerItem(Icons.dashboard_rounded, 'Dashboard', _selectedIndex == 0, () {
                    setState(() => _selectedIndex = 0);
                    Navigator.pop(context);
                  }),
                  _buildDrawerItem(Icons.person_rounded, 'Profile', _selectedIndex == 3, () {
                    setState(() => _selectedIndex = 3);
                    Navigator.pop(context);
                  }),
                  _buildDrawerItem(Icons.settings_rounded, 'Settings', false, () => Navigator.pop(context)),
                  _buildDrawerItem(Icons.help_outline_rounded, 'Help', false, () => Navigator.pop(context)),
                  const Divider(),
                  _buildDrawerItem(Icons.logout_rounded, 'Logout', false, () => Navigator.pop(context), isLogout: true),
                ],
              ),
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          PortalHomeScreen(),
          PortalAttendanceScreen(),
          PortalAssignmentsScreen(),
          PortalProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF4527A0),
        unselectedItemColor: Colors.grey.shade500,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: 'Attendance'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_rounded), label: 'Assignments'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      ),
    );
  }
  Widget _buildDrawerItem(IconData icon, String label, bool isSelected, VoidCallback onTap, {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : const Color(0xFF4527A0)),
      title: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: isLogout ? Colors.red : const Color(0xFF212121),
        ),
      ),
      selected: isSelected,
      selectedTileColor: const Color(0xFF4527A0).withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onTap: onTap,
    );
  }
}
