using SRP_StudentReportApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SRP_StudentReportApp.Services
{
    public class ReportGenerator
    {
        public void GenerateReport(List<Student> students)
        {
            Console.WriteLine("\n===== Student Report =====");

            foreach (var student in students)
            {
                Console.WriteLine($"ID: {student.StudentId}");
                Console.WriteLine($"Name: {student.StudentName}");
                Console.WriteLine($"Marks: {student.Marks}");
                Console.WriteLine($"Grade: {CalculateGrade(student.Marks)}");
                Console.WriteLine("--------------------------");
            }
        }

        private string CalculateGrade(double marks)
        {
            if (marks >= 90) return "A";
            else if (marks >= 75) return "B";
            else if (marks >= 50) return "C";
            else return "F";
        }
    }
}
