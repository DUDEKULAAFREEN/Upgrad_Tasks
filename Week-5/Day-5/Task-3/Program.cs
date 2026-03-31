using System;

class Program
{
    static (double, int) GetPerformance(double sales, int rating)
    {
        return (sales, rating);
    }

    static void Main()
    {
        Console.Write("Enter Employee Name: ");
        string name = Console.ReadLine();

        Console.Write("Enter Sales Amount: ");
        double sales = Convert.ToDouble(Console.ReadLine());

        Console.Write("Enter Rating (1-5): ");
        int rating = Convert.ToInt32(Console.ReadLine());

        var (s, r) = GetPerformance(sales, rating);

        string performance = (s, r) switch
        {
            ( >= 100000, >= 4) => "High Performer",
            ( >= 50000, >= 3) => "Average Performer",
            _ => "Needs Improvement"
        };

        Console.WriteLine("\nEmployee Name: " + name);
        Console.WriteLine("Sales Amount: " + s);
        Console.WriteLine("Rating: " + r);
        Console.WriteLine("Performance: " + performance);
    }
}