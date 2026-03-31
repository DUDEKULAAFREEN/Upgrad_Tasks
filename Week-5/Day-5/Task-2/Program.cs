using System;
using System.IO;

class Program
{
    static void Main()
    {
        try
        {
            Console.Write("Enter folder path: ");
            string path = Console.ReadLine();

            DirectoryInfo dir = new DirectoryInfo(path);

            if (!dir.Exists)
            {
                Console.WriteLine("Invalid directory path!");
                return;
            }

            FileInfo[] files = dir.GetFiles();
            int count = 0;

            foreach (FileInfo file in files)
            {
                Console.WriteLine($"Name: {file.Name}");
                Console.WriteLine($"Size: {file.Length} bytes");
                Console.WriteLine($"Created: {file.CreationTime}");
                Console.WriteLine("----------------------");
                count++;
            }

            Console.WriteLine("Total Files: " + count);
        }
        catch (Exception ex)
        {
            Console.WriteLine("Error: " + ex.Message);
        }
    }
}