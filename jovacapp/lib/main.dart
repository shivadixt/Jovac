import 'package:flutter/material.dart';
//import 'screens/food_menu.dart';
//import 'screens/cafe_ordering_screen.dart';
//import 'screens/user_preference.dart';
//import 'screens/Student_ID_Card.dart';
//import 'screens/profile_screen.dart';
//import 'screens/Image_card.dart';
//import 'screens/stack_widget.dart';
//import 'screens/home_screen.dart';
//import 'screens/edit_course_screen.dart';
//import 'screens/college_portal_screen.dart';
//import 'screens/student_registration_form.dart';
//import 'screens/student_info_portal.dart';
//import 'screens/student_assignment_portal.dart';
//import 'screens/student_placement_registration.dart';
import 'screens/hive_student_crud.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hive CRUD Students',
      home: const HiveStudentCrudScreen(),
      //home: const StudentPlacementRegistrationScreen(),
      //home: const StudentAssignmentPortalScreen(),
      //home: const StudentInfoPortalScreen(),
      //home: const StudentRegistrationForm(),
      //home: const CollegePortalScreen(),
      //home: const HomeScreen(),
      //home: const StudentIdCardScreen(),
      //home: const ProfileScreen(),
      //home: const ImageCard(),
      //home: const StackWidget(),
      //home: const FoodMenu(),
      //home: CafeOrderingScreen(),
      //home: UserPreferencesScreen(),
      // routes: {
      //   '/editCourse': (context) {
      //     final course = ModalRoute.of(context)!.settings.arguments as String? ?? 'Flutter';
      //     return EditCourseScreen(initialCourse: course);
      //   },
      // },
    );
  }
}