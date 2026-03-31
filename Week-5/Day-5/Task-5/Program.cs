using System;
using System.IO;

class Program
{
    static void Main()
    {
        try
        {
            DriveInfo[] drives = DriveInfo.GetDrives();

            foreach (DriveInfo drive in drives)
            {
                if (drive.IsReady)
                {
                    Console.WriteLine($"Drive Name: {drive.Name}");
                    Console.WriteLine($"Type: {drive.DriveType}");
                    Console.WriteLine($"Total Size: {drive.TotalSize / (1024 * 1024 * 1024)} GB");
                    Console.WriteLine($"Free Space: {drive.AvailableFreeSpace / (1024 * 1024 * 1024)} GB");

                    double freePercent = (double)drive.AvailableFreeSpace / drive.TotalSize * 100;

                    if (freePercent < 15)
                    {
                        Console.WriteLine("⚠ Warning: Low disk space!");
                    }

                    Console.WriteLine("----------------------");
                }
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine("Error: " + ex.Message);
        }
    }
}