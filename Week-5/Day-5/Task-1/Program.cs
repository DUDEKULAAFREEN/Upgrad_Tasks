using System;
using System.IO;
using System.Text;

class Program
{
    static void Main()
    {
        try
        {
            Console.Write("Enter a message: ");
            string message = Console.ReadLine();

            // Open file in Append mode
            using (FileStream fs = new FileStream("log.txt", FileMode.Append, FileAccess.Write))
            {
                byte[] data = Encoding.UTF8.GetBytes(message + Environment.NewLine);
                fs.Write(data, 0, data.Length);
            }

            Console.WriteLine("Message written successfully!");
        }
        catch (Exception ex)
        {
            Console.WriteLine("Error: " + ex.Message);
        }

        Console.ReadLine();
    }
}