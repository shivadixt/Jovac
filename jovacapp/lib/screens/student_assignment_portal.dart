import 'dart:async';
import 'package:flutter/material.dart';

class StudentAssignmentPortalScreen extends StatefulWidget {
  const StudentAssignmentPortalScreen({super.key});
  @override
  State<StudentAssignmentPortalScreen> createState() => _StudentAssignmentPortalScreenState();
}

class _StudentAssignmentPortalScreenState extends State<StudentAssignmentPortalScreen> {
  int _currentNavIndex = 0;
  DateTime _selectedDate = DateTime(2026, 7, 28);
  TimeOfDay _selectedTime = const TimeOfDay(hour: 15, minute: 30);
  String _selectedFileName = 'assignment_flutter.pdf';
  String _selectedFileSize = '2.3 MB';
  bool _isFileUploaded = true;
  double _rating = 4.5;
  String _submissionStatus = 'Pending';
  double _uploadProgress = 0.0;
  Timer? _uploadTimer;

  String _formatDate(DateTime dt) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${dt.day} ${months[dt.month - 1]} ${dt.year}';
  }

  String _formatTime(TimeOfDay tod) {
    final hour = tod.hourOfPeriod == 0 ? 12 : tod.hourOfPeriod;
    final minute = tod.minute.toString().padLeft(2, '0');
    final period = tod.period == DayPeriod.am ? 'AM' : 'PM';
    return '${hour.toString().padLeft(2, '0')}:$minute $period';
  }

  void _showFileSelectionModal(BuildContext context, Function(String name, String size) onSelect) {
    final List<Map<String, String>> sampleFiles = [
      {'name': 'assignment_flutter.pdf', 'size': '2.3 MB', 'type': 'pdf'},
      {'name': 'flutter_ui_widgets_task17.pdf', 'size': '3.1 MB', 'type': 'pdf'},
      {'name': 'flutter_project_solution.zip', 'size': '4.8 MB', 'type': 'zip'},
      {'name': 'assignment_report.docx', 'size': '1.5 MB', 'type': 'docx'},
    ];
    final customController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 16, bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
              ),
              const SizedBox(height: 14),
              const Text('Select PDF / Assignment File', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF4527A0))),
              const SizedBox(height: 12),
              ...sampleFiles.map((file) {
                final isPdf = file['type'] == 'pdf';
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: isPdf ? Colors.red.shade50 : Colors.indigo.shade50, borderRadius: BorderRadius.circular(8)),
                    child: Icon(isPdf ? Icons.picture_as_pdf_rounded : Icons.insert_drive_file_rounded, color: isPdf ? Colors.red : const Color(0xFF4527A0)),
                  ),
                  title: Text(file['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  subtitle: Text(file['size']!, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                  trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey),
                  onTap: () {
                    onSelect(file['name']!, file['size']!);
                    Navigator.pop(ctx);
                  },
                );
              }),
              const Divider(),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: customController,
                      style: const TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                        hintText: 'Enter custom file name (.pdf)',
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      final text = customController.text.trim();
                      if (text.isNotEmpty) {
                        final fullName = text.endsWith('.pdf') ? text : '$text.pdf';
                        onSelect(fullName, '2.0 MB');
                        Navigator.pop(ctx);
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4527A0)),
                    child: const Text('Add', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _startUpload(BuildContext context) {
    setState(() => _uploadProgress = 0.0);
    _uploadTimer?.cancel();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogCtx) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            _uploadTimer ??= Timer.periodic(const Duration(milliseconds: 80), (timer) {
              if (_uploadProgress >= 1.0) {
                timer.cancel();
                _uploadTimer = null;
                Navigator.pop(dialogCtx);
                setState(() => _submissionStatus = 'Submitted');
                _navigateToSuccess(context);
              } else {
                setDialogState(() {
                  _uploadProgress += 0.05;
                });
                setState(() {});
              }
            });
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(color: Color(0xFFEDE7F6), shape: BoxShape.circle),
                      child: const Icon(Icons.cloud_upload_rounded, color: Color(0xFF4527A0), size: 48),
                    ),
                    const SizedBox(height: 16),
                    const Text('Uploading Assignment...', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator(
                            value: _uploadProgress.clamp(0.0, 1.0),
                            strokeWidth: 8,
                            backgroundColor: Colors.grey.shade200,
                            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4527A0)),
                          ),
                        ),
                        Text(
                          '${(_uploadProgress.clamp(0.0, 1.0) * 100).toInt()}%',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF4527A0)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _navigateToSuccess(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => _SubmissionSuccessScreen(
        dateStr: _formatDate(_selectedDate),
        timeStr: _formatTime(_selectedTime),
        fileName: _selectedFileName,
        onRateTap: () => _navigateToRating(context),
      )),
    );
  }

  void _navigateToRating(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (ratingCtx) => _RatingScreen(
        initialRating: _rating,
        onSubmit: (newRating) {
          setState(() => _rating = newRating);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.star_rounded, color: Colors.amber),
                  const SizedBox(width: 8),
                  Text('Thank you! Rating submitted: $newRating / 5'),
                ],
              ),
              backgroundColor: const Color(0xFF4527A0),
              duration: const Duration(seconds: 3),
            ),
          );
        },
      )),
    );
  }

  @override
  void dispose() {
    _uploadTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FB),
      appBar: AppBar(
        title: const Text('Student Assignment Portal', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17)),
        leading: const Icon(Icons.menu_rounded, color: Colors.white),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_rounded, color: Colors.white), onPressed: () {}),
        ],
        backgroundColor: const Color(0xFF4527A0),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDE7F6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.school_rounded, size: 50, color: Color(0xFF4527A0)),
                        SizedBox(width: 16),
                        Icon(Icons.assignment_turned_in_rounded, size: 45, color: Color(0xFF7B1FA2)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Assignment Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF212121))),
                  ),
                  const SizedBox(height: 12),
                  _detailRow('Assignment', 'Flutter UI Widgets'),
                  _detailRow('Subject', 'Mobile Application Dev.'),
                  _detailRow('Faculty', 'Mr. Pankaj Kapoor'),
                  _detailRow('Last Date', '30 July 2026'),
                  _detailRow('Total Marks', '100'),
                  _detailRow('Status', _submissionStatus, valueColor: _submissionStatus == 'Submitted' ? Colors.green : Colors.orange),
                  if (_submissionStatus == 'Submitted') _detailRow('Your Rating', '$_rating / 5 ⭐', valueColor: const Color(0xFF4527A0)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => _SubmitAssignmentFormScreen(
                        selectedDate: _selectedDate,
                        selectedTime: _selectedTime,
                        fileName: _selectedFileName,
                        fileSize: _selectedFileSize,
                        isFileUploaded: _isFileUploaded,
                        onDateChanged: (d) => setState(() => _selectedDate = d),
                        onTimeChanged: (t) => setState(() => _selectedTime = t),
                        onFileRemove: () => setState(() => _isFileUploaded = false),
                        onOpenFilePicker: () {
                          _showFileSelectionModal(context, (name, size) {
                            setState(() {
                              _selectedFileName = name;
                              _selectedFileSize = size;
                              _isFileUploaded = true;
                            });
                          });
                        },
                        onSubmit: () => _startUpload(context),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.upload_file_rounded, color: Colors.white),
                label: const Text('Submit Assignment', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4527A0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const _GuidelinesScreen()));
                },
                icon: const Icon(Icons.description_outlined, color: Color(0xFF4527A0)),
                label: const Text('View Assignment Guidelines', style: TextStyle(color: Color(0xFF4527A0), fontSize: 15, fontWeight: FontWeight.bold)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF4527A0), width: 1.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const _TooltipDemoScreen()));
                },
                icon: const Icon(Icons.info_outline_rounded, color: Color(0xFF7B1FA2)),
                label: const Text('Widget Tooltip Demo', style: TextStyle(color: Color(0xFF7B1FA2), fontSize: 15, fontWeight: FontWeight.bold)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF7B1FA2), width: 1.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentNavIndex,
        onTap: (idx) => setState(() => _currentNavIndex = idx),
        selectedItemColor: const Color(0xFF4527A0),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.folder_special_rounded), label: 'My Submissions'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(width: 110, child: Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.w500))),
          Expanded(child: Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: valueColor ?? const Color(0xFF212121)))),
        ],
      ),
    );
  }
}

class _SubmitAssignmentFormScreen extends StatefulWidget {
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final String fileName;
  final String fileSize;
  final bool isFileUploaded;
  final ValueChanged<DateTime> onDateChanged;
  final ValueChanged<TimeOfDay> onTimeChanged;
  final VoidCallback onFileRemove;
  final VoidCallback onOpenFilePicker;
  final VoidCallback onSubmit;

  const _SubmitAssignmentFormScreen({
    required this.selectedDate,
    required this.selectedTime,
    required this.fileName,
    required this.fileSize,
    required this.isFileUploaded,
    required this.onDateChanged,
    required this.onTimeChanged,
    required this.onFileRemove,
    required this.onOpenFilePicker,
    required this.onSubmit,
  });

  @override
  State<_SubmitAssignmentFormScreen> createState() => _SubmitAssignmentFormScreenState();
}

class _SubmitAssignmentFormScreenState extends State<_SubmitAssignmentFormScreen> {
  late DateTime _d;
  late TimeOfDay _t;

  @override
  void initState() {
    super.initState();
    _d = widget.selectedDate;
    _t = widget.selectedTime;
  }

  String _formatDate(DateTime dt) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${dt.day} ${months[dt.month - 1]} ${dt.year}';
  }

  String _formatTime(TimeOfDay tod) {
    final hour = tod.hourOfPeriod == 0 ? 12 : tod.hourOfPeriod;
    final minute = tod.minute.toString().padLeft(2, '0');
    final period = tod.period == DayPeriod.am ? 'AM' : 'PM';
    return '${hour.toString().padLeft(2, '0')}:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FB),
      appBar: AppBar(
        title: const Text('Submit Assignment', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17)),
        backgroundColor: const Color(0xFF4527A0),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Submission Date', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF4527A0))),
            const SizedBox(height: 8),
            InkWell(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _d,
                  firstDate: DateTime(2025),
                  lastDate: DateTime(2030),
                );
                if (picked != null) {
                  setState(() => _d = picked);
                  widget.onDateChanged(picked);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade300)),
                child: Row(
                  children: [
                    Expanded(child: Text(_formatDate(_d), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600))),
                    const Icon(Icons.calendar_month_rounded, color: Color(0xFF4527A0)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Select Submission Time', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF4527A0))),
            const SizedBox(height: 8),
            InkWell(
              onTap: () async {
                final picked = await showTimePicker(context: context, initialTime: _t);
                if (picked != null) {
                  setState(() => _t = picked);
                  widget.onTimeChanged(picked);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade300)),
                child: Row(
                  children: [
                    Expanded(child: Text(_formatTime(_t), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600))),
                    const Icon(Icons.access_time_rounded, color: Color(0xFF4527A0)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Upload Assignment File', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF4527A0))),
            const SizedBox(height: 8),
            widget.isFileUploaded
                ? InkWell(
                    onTap: widget.onOpenFilePicker,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF4527A0), width: 1.5)),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(8)),
                            child: const Icon(Icons.picture_as_pdf_rounded, color: Colors.red, size: 24),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.fileName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                Text('${widget.fileSize} • Tap to change file', style: TextStyle(color: const Color(0xFF4527A0), fontSize: 11, fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close_rounded, color: Colors.grey),
                            onPressed: widget.onFileRemove,
                          ),
                        ],
                      ),
                    ),
                  )
                : InkWell(
                    onTap: widget.onOpenFilePicker,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFF4527A0), style: BorderStyle.solid),
                      ),
                      child: const Center(
                        child: Column(
                          children: [
                            Icon(Icons.cloud_upload_outlined, color: Color(0xFF4527A0), size: 36),
                            SizedBox(height: 6),
                            Text('Click to select / attach PDF file', style: TextStyle(color: Color(0xFF4527A0), fontWeight: FontWeight.bold, fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                  ),
            const SizedBox(height: 4),
            Text('(PDF, DOCX, ZIP files only)', style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: widget.isFileUploaded
                    ? () {
                        Navigator.pop(context);
                        widget.onSubmit();
                      }
                    : widget.onOpenFilePicker,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4527A0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text(widget.isFileUploaded ? 'Submit Assignment' : 'Select PDF File', style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubmissionSuccessScreen extends StatelessWidget {
  final String dateStr;
  final String timeStr;
  final String fileName;
  final VoidCallback onRateTap;

  const _SubmissionSuccessScreen({
    required this.dateStr,
    required this.timeStr,
    required this.fileName,
    required this.onRateTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FB),
      appBar: AppBar(
        title: const Text('Submission Successful', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17)),
        backgroundColor: const Color(0xFF4527A0),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(color: Color(0xFFE8F5E9), shape: BoxShape.circle),
              child: const Icon(Icons.check_circle_rounded, color: Color(0xFF2E7D32), size: 56),
            ),
            const SizedBox(height: 16),
            const Text(
              'Assignment Submitted\nSuccessfully!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  _row('Student Name', 'Rahul Sharma'),
                  _row('Assignment', 'Flutter UI Widgets'),
                  _row('Submission Date', dateStr),
                  _row('Submission Time', timeStr),
                  _row('Uploaded File', fileName, isFile: true),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: onRateTap,
                icon: const Icon(Icons.star_rounded, color: Colors.amber),
                label: const Text('Rate Your Experience', style: TextStyle(color: Color(0xFF4527A0), fontSize: 14, fontWeight: FontWeight.bold)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF4527A0), width: 1.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4527A0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Back to Home', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String val, {bool isFile = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.w500))),
          Expanded(
            child: isFile
                ? Row(
                    children: [
                      const Icon(Icons.picture_as_pdf_rounded, color: Colors.red, size: 18),
                      const SizedBox(width: 6),
                      Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    ],
                  )
                : Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          ),
        ],
      ),
    );
  }
}

class _RatingScreen extends StatefulWidget {
  final double initialRating;
  final ValueChanged<double> onSubmit;

  const _RatingScreen({required this.initialRating, required this.onSubmit});

  @override
  State<_RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<_RatingScreen> {
  late double _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
  }

  String _getRatingText(double r) {
    if (r >= 5.0) return 'Excellent! ⭐⭐⭐⭐⭐';
    if (r >= 4.0) return 'Very Good! ⭐⭐⭐⭐';
    if (r >= 3.0) return 'Good ⭐⭐⭐';
    if (r >= 2.0) return 'Average ⭐⭐';
    return 'Poor ⭐';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FB),
      appBar: AppBar(
        title: const Text('Rate Your Experience', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17)),
        backgroundColor: const Color(0xFF4527A0),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'How was your assignment\nsubmission experience?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF212121)),
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final starValue = (index + 1).toDouble();
                final isSelected = _rating >= starValue;
                return GestureDetector(
                  onTap: () {
                    setState(() => _rating = starValue);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(
                      isSelected ? Icons.star_rounded : Icons.star_outline_rounded,
                      color: Colors.amber,
                      size: 44,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            Text('$_rating / 5', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF4527A0))),
            const SizedBox(height: 4),
            Text(_getRatingText(_rating), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
            const SizedBox(height: 6),
            Text('Thank you for your feedback!', style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  widget.onSubmit(_rating);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4527A0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Submit Rating', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GuidelinesScreen extends StatelessWidget {
  const _GuidelinesScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FB),
      appBar: AppBar(
        title: const Text('Assignment Guidelines', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17)),
        backgroundColor: const Color(0xFF4527A0),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Assignment Guidelines', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF4527A0))),
              const SizedBox(height: 16),
              const Text('Objective', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text('Build a Flutter application using the widgets learned in the class.', style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
              const SizedBox(height: 16),
              const Text('Instructions', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              _bullet('Use proper UI design.'),
              _bullet('Follow best coding practices.'),
              _bullet('Submit before the last date.'),
              _bullet('Upload in PDF or ZIP format.'),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const _FlutterDocsWebViewScreen()));
                  },
                  icon: const Icon(Icons.language_rounded, color: Colors.white),
                  label: const Text('Open Flutter Documentation', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4527A0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}

class _FlutterDocsWebViewScreen extends StatelessWidget {
  const _FlutterDocsWebViewScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Flutter Documentation', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17)),
        backgroundColor: const Color(0xFF4527A0),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.flutter_dash, color: Color(0xFF02569B), size: 36),
                      const SizedBox(width: 8),
                      const Text('Flutter', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF02569B))),
                      const Spacer(),
                      IconButton(icon: const Icon(Icons.menu_rounded), onPressed: () {}),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text('Build apps for any platform', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF212121))),
                  const SizedBox(height: 12),
                  Text('Flutter is an open source UI software development kit created by Google.', style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF02569B)),
                    child: const Text('Get started', style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(color: const Color(0xFFE1F5FE), borderRadius: BorderRadius.circular(16)),
                    child: const Center(
                      child: Icon(Icons.devices_rounded, size: 70, color: Color(0xFF02569B)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(color: Colors.grey.shade100, border: Border(top: BorderSide(color: Colors.grey.shade300))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(icon: const Icon(Icons.arrow_back_ios_rounded, size: 18), onPressed: () {}),
                IconButton(icon: const Icon(Icons.arrow_forward_ios_rounded, size: 18), onPressed: () {}),
                IconButton(icon: const Icon(Icons.refresh_rounded), onPressed: () {}),
                IconButton(icon: const Icon(Icons.ios_share_rounded), onPressed: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TooltipDemoScreen extends StatelessWidget {
  const _TooltipDemoScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FB),
      appBar: AppBar(
        title: const Text('Tooltip Demo', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17)),
        backgroundColor: const Color(0xFF4527A0),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _tooltipCard(context, 'Select Date', Icons.calendar_month_rounded, const Color(0xFF4527A0)),
                  _tooltipCard(context, 'Select Time', Icons.access_time_rounded, const Color(0xFF1565C0)),
                  _tooltipCard(context, 'Upload File', Icons.folder_rounded, const Color(0xFFFF8F00)),
                  _tooltipCard(context, 'Rate Experience', Icons.star_rounded, const Color(0xFFF57F17)),
                  _tooltipCard(context, 'Open Guidelines', Icons.description_rounded, const Color(0xFF4A148C)),
                  _tooltipCard(context, 'Open Docs', Icons.language_rounded, const Color(0xFF02569B)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFFEDE7F6), borderRadius: BorderRadius.circular(12)),
              child: const Text('Long press on any icon to see tooltip', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF4527A0), fontWeight: FontWeight.bold, fontSize: 13)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tooltipCard(BuildContext context, String message, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Tooltip(
        message: message,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(color: const Color(0xFF212121), borderRadius: BorderRadius.circular(6)),
        textStyle: const TextStyle(color: Colors.white, fontSize: 12),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 36),
              const SizedBox(height: 6),
              Text(message, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}
