import 'package:flutter/material.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isFollowing=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:isFollowing? Colors.green: Colors.blue,
          title: Text(isFollowing? "Following Profile": "Flutter Profile"),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.person, size: 80, color: Colors.white),
                ),
                SizedBox(height: 20,),
                Text(
                  "Shiva Dixit",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10,),
                Text(
                  "Flutter Developer",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                SizedBox(height: 10,),
                Text(
                  "shiva@gmail.com",
                  textDirection:TextDirection.ltr,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20,),
                ElevatedButton.icon(onPressed:() {
                  setState(() {
                    isFollowing=!isFollowing;
                  });
                },
                icon:Icon(isFollowing?Icons.check: Icons.person_outline) ,
                style: ElevatedButton.styleFrom(
                  backgroundColor:isFollowing? Colors.green: Colors.blue,
                  foregroundColor: Colors.white,
                  fixedSize: const Size(220, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                ), label: Text(isFollowing? "Following": "Follow")),
              ],
            ),
          ),
        );
  }
}