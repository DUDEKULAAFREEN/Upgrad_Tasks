using System;

struct Student
{
    public int RollNo;
    public string Name;
    public string Course;
    public int Marks;
}

class Program
{
    static void Main()
    {
        Console.Write("Enter number of students: ");
        int n = Convert.ToInt32(Console.ReadLine());

        Student[] students = new Student[n];

        // Input student details
        for (int i = 0; i < n; i++)
        {
            Console.WriteLine("\nEnter details for Student " + (i + 1));

            Console.Write("Enter Roll Number: ");
            students[i].RollNo = Convert.ToInt32(Console.ReadLine());

            Console.Write("Enter Name: ");
            students[i].Name = Console.ReadLine();

            Console.Write("Enter Course: ");
            students[i].Course = Console.ReadLine();

            Console.Write("Enter Marks: ");
            int marks = Convert.ToInt32(Console.ReadLine());

            // Validation for marks
            if (marks < 0 || marks > 100)
            {
                Console.WriteLine("Invalid marks! Setting to 0.");
                marks = 0;
            }

            students[i].Marks = marks;
        }

        // Display all records
        Console.WriteLine("\nStudent Records:");
        for (int i = 0; i < n; i++)
        {
            Console.WriteLine("Roll No: " + students[i].RollNo +
                              " | Name: " + students[i].Name +
                              " | Course: " + students[i].Course +
                              " | Marks: " + students[i].Marks);
        }

        // Search by Roll Number
        Console.Write("\nSearch Roll Number: ");
        int searchRoll = Convert.ToInt32(Console.ReadLine());

        bool found = false;

        for (int i = 0; i < n; i++)
        {
            if (students[i].RollNo == searchRoll)
            {
                Console.WriteLine("\nStudent Found:");
                Console.WriteLine("Roll No: " + students[i].RollNo +
                                  " | Name: " + students[i].Name +
                                  " | Course: " + students[i].Course +
                                  " | Marks: " + students[i].Marks);
                found = true;
                break;
            }
        }

        if (!found)
        {
            Console.WriteLine("Record not found!");
        }
    }
}