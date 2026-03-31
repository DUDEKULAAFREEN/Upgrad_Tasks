using System;

// Create Calculator class
class Calculator
{
    // Method for Addition
    public int Add(int a, int b)
    {
        return a + b;
    }

    // Method for Subtraction
    public int Subtract(int a, int b)
    {
        return a - b;
    }
}

class Program
{
    static void Main()
    {
        // Taking input
        Console.Write("Enter First Number: ");
        int num1 = Convert.ToInt32(Console.ReadLine());

        Console.Write("Enter Second Number: ");
        int num2 = Convert.ToInt32(Console.ReadLine());

        // Creating object of Calculator
        Calculator calc = new Calculator();

        // Calling methods
        int addition = calc.Add(num1, num2);
        int subtraction = calc.Subtract(num1, num2);

        // Display output
        Console.WriteLine("Addition = " + addition);
        Console.WriteLine("Subtraction = " + subtraction);
    }
}