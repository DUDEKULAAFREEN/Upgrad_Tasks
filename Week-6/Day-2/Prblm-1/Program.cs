using SRP_StudentReportApp.Models;
using SRP_StudentReportApp.Data;
using SRP_StudentReportApp.Services;

namespace SRP_StudentReportApp
{
    class Program
    {
        static void Main(string[] args)
        {
            StudentRepository repo = new StudentRepository();
            ReportGenerator report = new ReportGenerator();

            // Add Students
            repo.AddStudent(new Student { StudentId = 1, StudentName = "Afreen", Marks = 85 });
            repo.AddStudent(new Student { StudentId = 2, StudentName = "Rahul", Marks = 92 });
            repo.AddStudent(new Student { StudentId = 3, StudentName = "Sneha", Marks = 45 });

            // Generate Report
            var students = repo.GetAllStudents();
            report.GenerateReport(students);
        }
    }
}