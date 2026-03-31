using System;
using System.Threading.Tasks;

class Program
{
    static async Task WriteLogAsync(string message)
    {
        Console.WriteLine($"Start writing: {message}");

        await Task.Delay(2000);

        Console.WriteLine($"Completed writing: {message}");
    }

    static async Task Main()
    {
        Console.WriteLine("Logging started...\n");

        Task t1 = WriteLogAsync("Log Entry 1");
        Task t2 = WriteLogAsync("Log Entry 2");
        Task t3 = WriteLogAsync("Log Entry 3");

        Console.WriteLine("Main thread is still running...\n");

        await Task.WhenAll(t1, t2, t3);

        Console.WriteLine("\nAll logs written successfully!");
        Console.ReadLine();
    }
}