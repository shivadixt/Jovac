import 'package:flutter/material.dart';
class PortalAssignmentsScreen extends StatelessWidget {
  const PortalAssignmentsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> assignments = [
      {
        'title': 'Flutter Assignment-13',
        'desc': 'Build Navigation UI',
        'due': 'Due: 22 May 2025',
        'tag': 'Due Tomorrow',
        'color': const Color(0xFFC62828),
      },
      {
        'title': 'Java Assignment-7',
        'desc': 'OOPs Concepts',
        'due': 'Due: 25 May 2025',
        'tag': '3 Days Left',
        'color': const Color(0xFFE65100),
      },
      {
        'title': 'Python Assignment-5',
        'desc': 'Functions & Modules',
        'due': 'Due: 28 May 2025',
        'tag': '6 Days Left',
        'color': const Color(0xFF2E7D32),
      },
    ];
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: assignments.length,
      itemBuilder: (context, index) {
        final a = assignments[index];
        final color = a['color'] as Color;
        return Container(
          margin: const EdgeInsets.only(bottom: 14),
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
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.description_rounded, color: color, size: 26),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(a['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            a['tag'] as String,
                            style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(a['desc'] as String, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                    const SizedBox(height: 4),
                    Text(a['due'] as String, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
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
