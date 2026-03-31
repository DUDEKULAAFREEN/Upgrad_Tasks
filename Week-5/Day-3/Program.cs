using System;

class Product
{
    private double price;

    public string Name { get; set; }

    public double Price
    {
        get { return price; }
        set
        {
            if (value >= 0)
                price = value;
            else
                Console.WriteLine("Price cannot be negative!");
        }
    }

    public virtual double CalculateDiscount()
    {
        return 0;
    }
}

class Electronics : Product
{
    public override double CalculateDiscount()
    {
        return Price * 0.05;
    }
}

class Clothing : Product
{
    public override double CalculateDiscount()
    {
        return Price * 0.15;
    }
}

class Program
{
    static void Main()
    {
        Product product;

        Console.Write("Enter Electronics Price: ");
        double ePrice = Convert.ToDouble(Console.ReadLine());

        product = new Electronics();
        product.Name = "Electronics Item";
        product.Price = ePrice;

        double eDiscount = product.CalculateDiscount();
        double eFinal = product.Price - eDiscount;

        Console.WriteLine("Final Price after 5% discount = " + eFinal);

        Console.WriteLine();

        Console.Write("Enter Clothing Price: ");
        double cPrice = Convert.ToDouble(Console.ReadLine());

        product = new Clothing();
        product.Name = "Clothing Item";
        product.Price = cPrice;

        double cDiscount = product.CalculateDiscount();
        double cFinal = product.Price - cDiscount;

        Console.WriteLine("Final Price after 15% discount = " + cFinal);
    }
}