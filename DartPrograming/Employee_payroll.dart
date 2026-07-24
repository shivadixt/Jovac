import 'dart:io';
class Employee
{
  String employee_id="";
  String employee_name="";
  String department="";
  void displayEmployeeInfo()
  {
    print("Employee ID : $employee_id");
    print("Employee Name : $employee_name");
    print("Department : $department");
  }
}
class Salary extends Employee
{
  double salary=0;
  double hra=0;
  double da=0;
  double bonus=0;
  double gross_salary=0;
  double net_salary=0;
  double tax=0;
  void calculateGrossSalary()
  {
    gross_salary=salary+hra+da+bonus;
  }
  void calculateTax()
  {
    if(gross_salary>80000)
      tax=0.20*gross_salary;
    else if(gross_salary>50000)
      tax=0.10*gross_salary;
    else
      tax=0;
  }
  void calculateNetSalary()
  {
    net_salary=gross_salary-tax;
  }
  void displaySalarySlip()
  {
    print('''
========================================== 
 EMPLOYEE SALARY SLIP 
========================================== 
Employee Id:$employee_id
Name:$employee_name
Department:$department

Basic Salary:₹$salary
HRA:₹$hra
DA:₹$da
Bonus:₹$bonus

Gross Salary:₹$gross_salary
Tax:₹$tax
Net Salary:₹$net_salary

==========================================''');
}
}
class Incentive extends Salary
{
  double performanceIncentive=0;
  @override
  void calculateGrossSalary()
  {
    gross_salary=salary+hra+da+bonus+performanceIncentive;
  }
}

void main()
{
  Incentive obj=new Incentive();
  print("Enter Employee Id");
  obj.employee_id=stdin.readLineSync()!;
  print("Enter employee name");
  obj.employee_name=stdin.readLineSync()!;
  print("Enter department name");
  obj.department=stdin.readLineSync()!;
  print("Enter basic salary");
  obj.salary=double.parse(stdin.readLineSync()!);
  print("Enter HRA");
  obj.hra=double.parse(stdin.readLineSync()!);
  print("Enter DA");
  obj.da=double.parse(stdin.readLineSync()!);
  print("Enter bonus");
  obj.bonus=double.parse(stdin.readLineSync()!);
  print("Enter Performance Incentive");
  obj.performanceIncentive=double.parse(stdin.readLineSync()!);
  obj.calculateGrossSalary();
  obj.calculateTax();
  obj.calculateNetSalary();
  obj.displaySalarySlip();
}
