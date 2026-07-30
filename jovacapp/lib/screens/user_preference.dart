import 'package:flutter/material.dart';

class UserPreferencesScreen extends StatefulWidget {
  const UserPreferencesScreen({super.key});
  @override
  State<UserPreferencesScreen> createState() => _UserPreferencesScreenState();
}

class _UserPreferencesScreenState extends State<UserPreferencesScreen> {
  bool notificationsEnabled = true;
  int themeIndex = 1;
  String selectedGender = "Female";
  bool termsAccepted = true;
  double fontSize = 20;
  String selectedInterest = "Flutter";
  int currentStep = 1;
  @override
  Widget build(BuildContext context) {
    final bool isDark = themeIndex == 1;
    final Color bgColor = isDark ? Colors.grey[900]! : Colors.white;
    final Color textColor = isDark ? Colors.white : Colors.black87;
    final Color cardColor = isDark ? Colors.grey[850]! : Colors.white;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text("User Preferences"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Enable Notifications",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Switch(
                  value: notificationsEnabled,
                  activeColor: Colors.deepPurple,
                  onChanged: (value) {
                    setState(() {
                      notificationsEnabled = value;
                    });
                  },
                ),
              ],
            ),
            Text(
              "Notifications: ${notificationsEnabled ? "Enabled" : "Disabled"}",
              style: const TextStyle(color: Colors.deepPurple),
            ),
            const Divider(height: 30),
            Text(
              "Choose Theme",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 10),

            ToggleButtons(
              borderRadius: BorderRadius.circular(10),
              selectedColor: Colors.white,
              fillColor: Colors.deepPurple,
              color: Colors.deepPurple,
              isSelected: [
                themeIndex == 0,
                themeIndex == 1,
              ], 
              onPressed: (index) {
                setState(() {
                  themeIndex = index;
                });
              },
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Icon(Icons.wb_sunny),
                      SizedBox(width: 6),
                      Text("Light"),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Icon(Icons.nightlight_round),
                      SizedBox(width: 8),
                      Text("Dark"),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),
            Text(
              "Selected Mode: ${themeIndex == 0 ? "Light" : "Dark"}",
              style: const TextStyle(color: Colors.deepPurple),
            ),

            const Divider(height: 30),
            Text(
              "Select Gender",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Radio<String>(
                  value: "Male",
                  groupValue: selectedGender,
                  activeColor: Colors.deepPurple,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value!;
                    });
                  },
                ),
                Text("Male", style: TextStyle(color: textColor)),

                const SizedBox(width: 10),

                Radio<String>(
                  value: "Female",
                  groupValue: selectedGender,
                  activeColor: Colors.deepPurple,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value!;
                    });
                  },
                ),
                Text("Female", style: TextStyle(color: textColor)),

                const SizedBox(width: 10),

                Radio<String>(
                  value: "Other",
                  groupValue: selectedGender,
                  activeColor: Colors.deepPurple,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value!;
                    });
                  },
                ),
                Text("Other", style: TextStyle(color: textColor)),
              ],
            ),

            const SizedBox(height: 8),
            Text(
              "Selected Gender: $selectedGender",
              style: const TextStyle(color: Colors.deepPurple),
            ),

            const Divider(height: 30),
            Row(
              children: [
                Checkbox(
                  value: termsAccepted,
                  activeColor: Colors.green,
                  onChanged: (value) {
                    setState(() {
                      termsAccepted = value!;
                    });
                  },
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: textColor, fontSize: 14),
                      children: [
                        const TextSpan(text: "I accept the "),
                        TextSpan(
                          text: "Terms & Conditions",
                          style: const TextStyle(
                            color: Colors.deepPurple,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                "Status: ${termsAccepted ? "Accepted" : "Not Accepted"}",
                style: const TextStyle(color: Colors.deepPurple),
              ),
            ),

            const Divider(height: 30),
            Text(
              "Font Size (Sample Text)",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                const Text("10"),
                Expanded(
                  child: Slider(
                    value: fontSize,
                    min: 10,
                    max: 30,
                    activeColor: Colors.deepPurple,
                    onChanged: (value) {
                      setState(() {
                        fontSize = value;
                      });
                    },
                  ),
                ),
                const Text("30"),
                const SizedBox(width: 10),
                Text(
                  "Current Size: ${fontSize.toInt()}",
                  style: const TextStyle(color: Colors.deepPurple),
                ),
              ],
            ),

            const SizedBox(height: 10),
            Center(
              child: Text(
                "Flutter is Awesome!",
                style: TextStyle(
                  fontSize: fontSize,
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const Divider(height: 30),
            Text(
              "Choose Your Interests (Select One)",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 10),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: ["Flutter", "AI", "Web Development", "Game Development"]
                  .map((interest) {
                    return ChoiceChip(
                      label: Text(interest),
                      selected: selectedInterest == interest,
                      selectedColor: Colors.deepPurple,
                      labelStyle: TextStyle(
                        color: selectedInterest == interest
                            ? Colors.white
                            : Colors.deepPurple,
                      ),
                      onSelected: (isSelected) {
                        setState(() {
                          selectedInterest = interest;
                        });
                      },
                    );
                  })
                  .toList(),
            ),

            const SizedBox(height: 8),
            Text(
              "Selected Interest: $selectedInterest",
              style: const TextStyle(color: Colors.deepPurple),
            ),

            const Divider(height: 30),
            Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      notificationsEnabled = true;
                      themeIndex = 1;
                      selectedGender = "Female";
                      termsAccepted = true;
                      fontSize = 20;
                      selectedInterest = "Flutter";
                    });
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text("Reset"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.deepPurple,
                    side: const BorderSide(color: Colors.deepPurple),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Preferences Saved Successfully!"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  icon: const Icon(Icons.save),
                  label: const Text("Save"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            const Divider(height: 30,),
          ],
        ),
      ),
    );
  }
}
