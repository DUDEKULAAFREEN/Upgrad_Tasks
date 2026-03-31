using System;

class Program
{
    static void Main()
    {
        // Input
        Console.Write("Enter Number: ");
        int n = Convert.ToInt32(Console.ReadLine());

        int evenCount = 0;
        int oddCount = 0;
        int sum = 0;

        // Loop from 1 to N
        for (int i = 1; i <= n; i++)
        {
            sum += i;

            if (i % 2 == 0)
                evenCount++;
            else
                oddCount++;
        }

        // Output
        Console.WriteLine("Even Count: " + evenCount);
        Console.WriteLine("Odd Count: " + oddCount);
        Console.WriteLine("Sum: " + sum);
    }
}