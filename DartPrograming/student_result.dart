void main()
{
  String student="John Doe";
  int rollno=101;
  String course="BCA";
  int semester=3;
  int subject1_marks=85;
  int subject2_marks=78;
  int subject3_marks=91;
  int total=subject1_marks+subject2_marks+subject3_marks;
  double avg=total/3;
  double percentage=(total/300)*100;
  bool isPassed=true;
  subject1_marks+=5;
  total=subject1_marks+subject2_marks+subject3_marks;
  avg=total/3;
  percentage=(total/300)*100;
  if(percentage>=40)
    isPassed=true;
  else
    isPassed=false;
  if(isPassed)
  {
    print('''
==========================================    
 STUDENT RESULT REPORT 
==========================================

Student Name : $student 
Roll Number : $rollno
Course : $course
Semester : $semester 

Subject 1 : $subject1_marks 
Subject 2 : $subject2_marks 
Subject 3 : $subject3_marks 
 Total Marks : $total 
Average : ${avg.toStringAsFixed(2)}%
Percentage : ${percentage.toStringAsFixed(2)}%
 Result : Pass 

==========================================
''');
  }
  else
  {
    print('''
==========================================    
 STUDENT RESULT REPORT 
==========================================

Student Name : $student 
Roll Number : $rollno
Course : $course
Semester : $semester 

Subject 1 : $subject1_marks 
Subject 2 : $subject2_marks 
Subject 3 : $subject3_marks 
 Total Marks : $total 
Average : ${avg.toStringAsFixed(2)}% 
Percentage : ${percentage.toStringAsFixed(2)}% 
 Result : Fail 

==========================================
''');
  }
}