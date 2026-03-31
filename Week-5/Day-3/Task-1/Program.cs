using System;

// Record type
record Student(int RollNumber, string Name, string Course, int Marks);

class Program
{
    static void Main()
    {
        Console.Write("Enter number of students: ");
        int n = int.Parse(Console.ReadLine());

        Student[] students = new Student[n];

        // Input
        for (int i = 0; i < n; i++)
        {
            Console.WriteLine($"\nEnter details for student {i + 1}:");

            Console.Write("Roll Number: ");
            int roll = int.Parse(Console.ReadLine());

            Console.Write("Name: ");
            string name = Console.ReadLine();

            Console.Write("Course: ");
            string course = Console.ReadLine();

            Console.Write("Marks: ");
            int marks = int.Parse(Console.ReadLine());

            // Validation
            if (marks < 0 || marks > 100)
            {
                Console.WriteLine("Invalid marks! Setting to 0.");
                marks = 0;
            }

            students[i] = new Student(roll, name, course, marks);
        }

        // Display
        Console.WriteLine("\nStudent Records:");
        foreach (var s in students)
        {
            Console.WriteLine($"Roll No: {s.RollNumber} | Name: {s.Name} | Course: {s.Course} | Marks: {s.Marks}");
        }

        // Search
        Console.Write("\nEnter Roll Number to search: ");
        int searchRoll = int.Parse(Console.ReadLine());

        bool found = false;

        foreach (var s in students)
        {
            if (s.RollNumber == searchRoll)
            {
                Console.WriteLine("\nStudent Found:");
                Console.WriteLine($"Roll No: {s.RollNumber} | Name: {s.Name} | Course: {s.Course} | Marks: {s.Marks}");
                found = true;
                break;
            }
        }

        if (!found)
        {
            Console.WriteLine("Student not found.");
        }
    }
}