using System;

class Student
{
    // Method using out parameters
    public void CalculateResult(int m1, int m2, int m3, out int total, out double average)
    {
        total = m1 + m2 + m3;
        average = total / 3.0;
    }
}

class Program
{
    static void Main()
    {
        char choice;

        do
        {
            // Input marks
            Console.Write("Enter Marks 1: ");
            int m1 = Convert.ToInt32(Console.ReadLine());

            Console.Write("Enter Marks 2: ");
            int m2 = Convert.ToInt32(Console.ReadLine());

            Console.Write("Enter Marks 3: ");
            int m3 = Convert.ToInt32(Console.ReadLine());

            // Validation
            if (m1 < 0 || m1 > 100 || m2 < 0 || m2 > 100 || m3 < 0 || m3 > 100)
            {
                Console.WriteLine("Invalid marks! Enter values between 0 and 100.");
            }
            else
            {
                Student s = new Student();

                int total;
                double average;

                // Calling method
                s.CalculateResult(m1, m2, m3, out total, out average);

                // Result
                string result = (average >= 40) ? "Pass" : "Fail";

                // Output
                Console.WriteLine("Total Marks: " + total);
                Console.WriteLine("Average Marks: " + average);
                Console.WriteLine("Result: " + result);
            }

            // Repeat option
            Console.Write("Do you want to enter another student? (y/n): ");
            choice = Convert.ToChar(Console.ReadLine());

        } while (choice == 'y' || choice == 'Y');
    }
}