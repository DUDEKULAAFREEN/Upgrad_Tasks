using System;

class Calculator
{
    public void Divide(int numerator, int denominator)
    {
        try
        {
            int result = numerator / denominator;
            Console.WriteLine("Result = " + result);
        }
        catch (DivideByZeroException)
        {
            Console.WriteLine("Error: Cannot divide by zero");
        }
        finally
        {
            Console.WriteLine("Operation completed safely");
        }
    }
}

class Program
{
    static void Main()
    {
        Console.Write("Enter Numerator: ");
        int num = Convert.ToInt32(Console.ReadLine());

        Console.Write("Enter Denominator: ");
        int den = Convert.ToInt32(Console.ReadLine());

        Calculator calc = new Calculator();

        // Calling method
        calc.Divide(num, den);

        // Program continues
        Console.WriteLine("Program continues after handling exception...");
    }
}