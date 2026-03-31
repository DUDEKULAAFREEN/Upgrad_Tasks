using System;

class Employee
{
    public string Name { get; set; }
    public double BaseSalary { get; set; }

    public virtual double CalculateSalary()
    {
        return BaseSalary;
    }
}

class Manager : Employee
{
    public override double CalculateSalary()
    {
        return BaseSalary + (BaseSalary * 0.20);
    }
}

class Developer : Employee
{
    public override double CalculateSalary()
    {
        return BaseSalary + (BaseSalary * 0.10);
    }
}

class Program
{
    static void Main()
    {
        Console.Write("Enter Base Salary: ");
        double baseSalary = Convert.ToDouble(Console.ReadLine());

        Employee emp;


        emp = new Manager();
        emp.BaseSalary = baseSalary;
        double managerSalary = emp.CalculateSalary();

        emp = new Developer();
        emp.BaseSalary = baseSalary;
        double developerSalary = emp.CalculateSalary();

        Console.WriteLine("Manager Salary = " + managerSalary);
        Console.WriteLine("Developer Salary = " + developerSalary);
    }
}