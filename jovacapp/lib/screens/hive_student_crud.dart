import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveStudentCrudScreen extends StatefulWidget {
  const HiveStudentCrudScreen({super.key});
  @override
  State<HiveStudentCrudScreen> createState() => _HiveStudentCrudScreenState();
}

class _HiveStudentCrudScreenState extends State<HiveStudentCrudScreen> {
  Box? _studentBox;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initHive();
  }

  Future<void> _initHive() async {
    await Hive.initFlutter();
    _studentBox = await Hive.openBox('students_box');

    if (_studentBox!.isEmpty) {
      await _studentBox!.put(1, {'id': 1, 'name': 'Rahul', 'course': 'BCA', 'age': 20});
      await _studentBox!.put(2, {'id': 2, 'name': 'Aman', 'course': 'B.Tech', 'age': 21});
      await _studentBox!.put(3, {'id': 3, 'name': 'Priya', 'course': 'MBA', 'age': 23});
      await _studentBox!.put(4, {'id': 4, 'name': 'Neha', 'course': 'MCA', 'age': 22});
      await _studentBox!.put(5, {'id': 5, 'name': 'Rohit', 'course': 'BBA', 'age': 19});
    }

    setState(() => _isLoading = false);
  }

  void _deleteStudent(dynamic key) async {
    await _studentBox!.delete(key);
    setState(() {});
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Student Record Deleted'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _addStudentDialog() {
    final nameCtrl = TextEditingController();
    final courseCtrl = TextEditingController();
    final ageCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Add New Student', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF512DA8))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Name')),
            TextField(controller: courseCtrl, decoration: const InputDecoration(labelText: 'Course')),
            TextField(controller: ageCtrl, decoration: const InputDecoration(labelText: 'Age'), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF512DA8)),
            onPressed: () async {
              if (nameCtrl.text.trim().isNotEmpty) {
                final newId = (_studentBox!.keys.isEmpty) ? 1 : (_studentBox!.keys.cast<int>().reduce((a, b) => a > b ? a : b) + 1);
                await _studentBox!.put(newId, {
                  'id': newId,
                  'name': nameCtrl.text.trim(),
                  'course': courseCtrl.text.trim().isEmpty ? 'General' : courseCtrl.text.trim(),
                  'age': int.tryParse(ageCtrl.text.trim()) ?? 20,
                });
                setState(() {});
                if (ctx.mounted) Navigator.pop(ctx);
              }
            },
            child: const Text('Add', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FB),
      appBar: AppBar(
        title: const Text('Hive CRUD Students', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        leading: const Icon(Icons.menu_rounded, color: Colors.white),
        backgroundColor: const Color(0xFF512DA8),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded, color: Colors.white),
            onPressed: _addStudentDialog,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF512DA8)))
          : ValueListenableBuilder(
              valueListenable: _studentBox!.listenable(),
              builder: (context, Box box, _) {
                if (box.isEmpty) {
                  return const Center(
                    child: Text('No Student Records Found', style: TextStyle(color: Colors.grey, fontSize: 16)),
                  );
                }

                final keys = box.keys.toList();
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: keys.length,
                  itemBuilder: (context, index) {
                    final key = keys[index];
                    final student = Map<String, dynamic>.from(box.get(key) as Map);
                    final id = student['id'] ?? key;
                    final name = student['name'] ?? '';
                    final course = student['course'] ?? '';
                    final age = student['age'] ?? 0;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.08), blurRadius: 8, offset: const Offset(0, 3))],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF212121))),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text('$course | Age : $age | ID : $id', style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit_outlined, color: Color(0xFF512DA8)),
                              onPressed: () async {
                                final updated = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => UpdateStudentScreen(
                                      studentKey: key,
                                      studentData: student,
                                      studentBox: box,
                                    ),
                                  ),
                                );
                                if (updated == true) {
                                  setState(() {});
                                }
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline_rounded, color: Colors.red),
                              onPressed: () => _deleteStudent(key),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF512DA8),
        onPressed: _addStudentDialog,
        child: const Icon(Icons.add_rounded, color: Colors.white),
      ),
    );
  }
}

class UpdateStudentScreen extends StatefulWidget {
  final dynamic studentKey;
  final Map<String, dynamic> studentData;
  final Box studentBox;

  const UpdateStudentScreen({
    super.key,
    required this.studentKey,
    required this.studentData,
    required this.studentBox,
  });

  @override
  State<UpdateStudentScreen> createState() => _UpdateStudentScreenState();
}

class _UpdateStudentScreenState extends State<UpdateStudentScreen> {
  late TextEditingController _nameController;
  late TextEditingController _courseController;
  late TextEditingController _ageController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.studentData['name']?.toString() ?? '');
    _courseController = TextEditingController(text: widget.studentData['course']?.toString() ?? '');
    _ageController = TextEditingController(text: widget.studentData['age']?.toString() ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _courseController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _updateStudent() async {
    final name = _nameController.text.trim();
    final course = _courseController.text.trim();
    final age = int.tryParse(_ageController.text.trim()) ?? widget.studentData['age'];

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter student name'), backgroundColor: Colors.red),
      );
      return;
    }

    final updatedData = {
      'id': widget.studentData['id'] ?? widget.studentKey,
      'name': name,
      'course': course,
      'age': age,
    };

    await widget.studentBox.put(widget.studentKey, updatedData);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Student Record Updated Successfully'),
          backgroundColor: Color(0xFF2E7D32),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FB),
      appBar: AppBar(
        title: const Text('Update Student', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17)),
        backgroundColor: const Color(0xFF512DA8),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildField(_nameController, 'Name', 'Enter student name'),
              const SizedBox(height: 16),
              _buildField(_courseController, 'Course', 'Enter course'),
              const SizedBox(height: 16),
              _buildField(_ageController, 'Age', 'Enter age', keyboardType: TextInputType.number),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _updateStudent,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF512DA8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('UPDATE STUDENT', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context, false),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF512DA8), width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('CANCEL', style: TextStyle(color: Color(0xFF512DA8), fontSize: 14, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController controller, String label, String hint, {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 13, color: Colors.grey.shade700, fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF512DA8), width: 2)),
          ),
        ),
      ],
    );
  }
}
