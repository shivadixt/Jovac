import 'dart:io';

void main()
{
    List<String> names=["Rahul", "Priya","Aman", "Sneha","Karan"];
    Map<String, dynamic> marks={};
    for(String i in names)
    {
        print("Enter marks for subject $i");
        int value=int.parse(stdin.readLineSync()!);
        marks[i]=value;
    }
    //printing names using for loop
    for(int i=0;i<names.length;i++)
    {
        print(names[i]);
    }
    //printing names using while loop
    int i=0;
    while(i<names.length)
    {
        print(names[i]);
        i++;
    }
    //printing names using do-while loop
    i=0;
    do
    {
        print(names[i]);
        i++;
    }while(i<names.length);
    //printing names using for-in loop
    for(String s in names)
    print(s);
    //printing names using for-each loop
    marks.forEach((key, value)
    {
        print(key);
    });

    marks.forEach((key, value)
    {
        String grade="";
        if(value>=90)
        {
            grade="A+";
            print("Name:$key, Marks:$value, Grade:A+");
        }
        else if(value>=80)
        {
            grade="A";
            print("Name:$key, Marks:$value, Grade:A");
        }
        else if(value>=70)
        {
            grade="B";
            print("Name:$key, Marks:$value, Grade:B");
        }
        else if(value>=60)
        {
            grade="C";
            print("Name:$key, Marks:$value, Grade:C");
        }
        else if(value>=40)
        {
            grade="D";
            print("Name:$key, Marks:$value, Grade:D");
        }
        else
        {
            grade="Fail";
            print("Name:$key, Marks:$value, Grade:Fail");
        }
    });

    print('''========================================= 
 STUDENT GRADE REPORT 
=========================================''');
    marks.forEach((key, value)
    {
        String grade="";
        if(value>=90)
            grade="A+";
        else if(value>=80)
            grade="A";
        else if(value>=70)
            grade="B";
        else if(value>=60)
            grade="C";
        else if(value>=40)
            grade="D";
        else
            grade="Fail";
        switch(grade)
        {
            case "A+":print('''
            Name:$key
            Marks:$value
            Grade:$grade
            Remarks:Outstanding''');
            break;
            case "A":print('''
            Name:$key
            Marks:$value
            Grade:$grade
            Remarks:Excellent''');
            break;
            case "B":print('''
            Name:$key
            Marks:$value
            Grade:$grade
            Remarks:Very Good''');
            break;
            case "C":print('''
            Name:$key
            Marks:$value
            Grade:$grade
            Remarks:Good''');
            break;
            case "D":print('''
            Name:$key
            Marks:$value
            Grade:$grade
            Remarks:Needs Improvement''');
            break;
            case "Fail":print('''
            Name:$key
            Marks:$value
            Grade:$grade
            Remarks:Failed''');
            break;
            default:print("Invalid Grade");
        }
        print("-----------------------------------------");
    });
    print("=========================================");
}
