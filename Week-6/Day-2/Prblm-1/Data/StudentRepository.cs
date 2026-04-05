using SRP_StudentReportApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SRP_StudentReportApp.Data
{
    public class StudentRepository
    {
        private List<Student> students = new List<Student>();

        public void AddStudent(Student student)
        {
            students.Add(student);
        }

        public List<Student> GetAllStudents()
        {
            return students;
        }
    }
}
