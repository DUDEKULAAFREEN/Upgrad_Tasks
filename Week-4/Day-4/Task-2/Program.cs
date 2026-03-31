using System;

// Student class
class Student
{
    // Method to calculate average
    public double CalculateAverage(int m1, int m2, int m3)
    {
        return (m1 + m2 + m3) / 3.0;
    }
}

class Program
{
    static void Main()
    {
        // Input marks
        Console.Write("Enter Marks 1: ");
        int m1 = Convert.ToInt32(Console.ReadLine());

        Console.Write("Enter Marks 2: ");
        int m2 = Convert.ToInt32(Console.ReadLine());

        Console.Write("Enter Marks 3: ");
        int m3 = Convert.ToInt32(Console.ReadLine());

        // Create object
        Student student = new Student();

        // Calculate average
        double avg = student.CalculateAverage(m1, m2, m3);

        string grade;

        // Determine grade based on average
        if (avg >= 90)
            grade = "A";
        else if (avg >= 75)
            grade = "B";
        else if (avg >= 60)
            grade = "C";
        else if (avg >= 40)
            grade = "D";
        else
            grade = "Fail";

        // Output
        Console.WriteLine("Average = " + avg);
        Console.WriteLine("Grade = " + grade);
    }
}