using System;

class Vehicle
{
    private double rentalRatePerDay;

    public string Brand { get; set; }

    public double RentalRatePerDay
    {
        get { return rentalRatePerDay; }
        set
        {
            if (value >= 0)
                rentalRatePerDay = value;
            else
                Console.WriteLine("Invalid rental rate!");
        }
    }

    public virtual double CalculateRental(int days)
    {
        return RentalRatePerDay * days;
    }
}

class Car : Vehicle
{
    public override double CalculateRental(int days)
    {
        double baseAmount = RentalRatePerDay * days;
        return baseAmount + 500; 
    }
}

class Bike : Vehicle
{
    public override double CalculateRental(int days)
    {
        double baseAmount = RentalRatePerDay * days;
        double discount = baseAmount * 0.05;
        return baseAmount - discount;
    }
}

class Program
{
    static void Main()
    {
        Console.Write("Enter Rental Days: ");
        int days = Convert.ToInt32(Console.ReadLine());

        if (days <= 0)
        {
            Console.WriteLine("Invalid number of days!");
            return;
        }

        Vehicle vehicle;

        // Car
        Console.Write("Enter Car Rental Rate Per Day: ");
        double carRate = Convert.ToDouble(Console.ReadLine());

        vehicle = new Car();
        vehicle.Brand = "Car";
        vehicle.RentalRatePerDay = carRate;

        double carTotal = vehicle.CalculateRental(days);
        Console.WriteLine("Car Total Rental = " + carTotal);

        Console.WriteLine();

        // Bike
        Console.Write("Enter Bike Rental Rate Per Day: ");
        double bikeRate = Convert.ToDouble(Console.ReadLine());

        vehicle = new Bike();
        vehicle.Brand = "Bike";
        vehicle.RentalRatePerDay = bikeRate;

        double bikeTotal = vehicle.CalculateRental(days);
        Console.WriteLine("Bike Total Rental = " + bikeTotal);
    }
}