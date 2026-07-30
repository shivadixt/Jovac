import 'package:flutter/material.dart';
class PortalProfileScreen extends StatelessWidget {
  const PortalProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 36),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4527A0), Color(0xFF7B1FA2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.person_rounded, size: 60, color: Colors.white),
                ),
                SizedBox(height: 14),
                Text('Shiva Dixit', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('B.Tech CSE  |  3rd Year', style: TextStyle(color: Colors.white70, fontSize: 14)),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 12, offset: const Offset(0, 4))],
            ),
            child: Column(
              children: [
                _infoRow('Name', 'Shiva Dixit'),
                const Divider(height: 1),
                _infoRow('Roll Number', '55'),
                const Divider(height: 1),
                _infoRow('Branch', 'Computer Science'),
                const Divider(height: 1),
                _infoRow('Year', '3rd Year'),
                const Divider(height: 1),
                _infoRow('Email', 'shiva0123@gmail.com'),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(label, style: TextStyle(fontSize: 14, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF212121))),
          ),
        ],
      ),
    );
  }
}
