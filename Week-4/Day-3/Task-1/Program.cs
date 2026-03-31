using System;

class Program
{
    static void Main()
    {
        Console.Write("Enter Name: ");
        string name = Console.ReadLine();

        Console.Write("Enter Marks: ");
        string input = Console.ReadLine();

        int marks;

        if (!int.TryParse(input, out marks))
        {
            Console.WriteLine("Invalid input! Please enter a valid number.");
            return;
        }


        if (marks < 0 || marks > 100)
        {
            Console.WriteLine("Invalid marks! Marks should be between 0 and 100.");
            return;
        }

        string grade;

        if (marks >= 90)
            grade = "A";
        else if (marks >= 75)
            grade = "B";
        else if (marks >= 60)
            grade = "C";
        else if (marks >= 40)
            grade = "D";
        else
            grade = "Fail";

        Console.WriteLine("Student: " + name);
        Console.WriteLine("Grade: " + grade);
    }
}