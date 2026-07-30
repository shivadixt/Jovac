import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/student_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('students.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE students (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        studentName TEXT NOT NULL,
        rollNumber TEXT NOT NULL,
        email TEXT NOT NULL,
        mobile TEXT NOT NULL,
        department TEXT NOT NULL,
        semester TEXT NOT NULL,
        cgpa REAL NOT NULL
      )
    ''');
  }

  Future<int> insertStudent(StudentModel student) async {
    final db = await instance.database;
    return await db.insert('students', student.toMap());
  }

  Future<List<StudentModel>> getAllStudents() async {
    final db = await instance.database;
    final result = await db.query('students', orderBy: 'id DESC');
    return result.map((json) => StudentModel.fromMap(json)).toList();
  }

  Future<List<StudentModel>> searchStudents(String query) async {
    final db = await instance.database;
    final result = await db.query(
      'students',
      where: 'studentName LIKE ? OR rollNumber LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'id DESC',
    );
    return result.map((json) => StudentModel.fromMap(json)).toList();
  }

  Future<int> updateStudent(StudentModel student) async {
    final db = await instance.database;
    return await db.update(
      'students',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  Future<int> deleteStudent(int id) async {
    final db = await instance.database;
    return await db.delete(
      'students',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
