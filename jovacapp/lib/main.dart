import 'package:flutter/material.dart';
//import 'screens/Student_ID_Card.dart';
//import 'screens/profile_screen.dart';
import 'screens/Image_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: const StudentIdCardScreen(),
      //home: const ProfileScreen(),
      home: const ImageCard(),
    );
  }
}