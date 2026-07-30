import 'package:flutter/material.dart';
class PortalAttendanceScreen extends StatelessWidget {
  const PortalAttendanceScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 24),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 190,
                height: 190,
                child: CircularProgressIndicator(
                  value: 0.85,
                  strokeWidth: 16,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4527A0)),
                ),
              ),
              const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('85%', style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold, color: Color(0xFF4527A0))),
                  Text('Present', style: TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 40),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: Column(
              children: [
                _statRow(Icons.grid_view_rounded, 'Total Classes', '120', const Color(0xFF4527A0)),
                const Divider(height: 1),
                _statRow(Icons.check_circle_rounded, 'Classes Attended', '102', const Color(0xFF2E7D32)),
                const Divider(height: 1),
                _statRow(Icons.cancel_rounded, 'Classes Remaining', '18', const Color(0xFFC62828)),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _statRow(IconData icon, String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Row(
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(width: 16),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500))),
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}
