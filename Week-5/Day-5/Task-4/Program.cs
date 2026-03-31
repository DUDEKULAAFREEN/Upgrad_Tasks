using System;
using System.IO;

class Program
{
    static void Main()
    {
        try
        {
            Console.Write("Enter root directory path: ");
            string path = Console.ReadLine();

            DirectoryInfo dir = new DirectoryInfo(path);

            if (!dir.Exists)
            {
                Console.WriteLine("Invalid path!");
                return;
            }

            DirectoryInfo[] subDirs = dir.GetDirectories();

            foreach (DirectoryInfo sub in subDirs)
            {
                FileInfo[] files = sub.GetFiles();
                Console.WriteLine($"Folder: {sub.Name}");
                Console.WriteLine($"File Count: {files.Length}");
                Console.WriteLine("----------------------");
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine("Error: " + ex.Message);
        }
    }
}