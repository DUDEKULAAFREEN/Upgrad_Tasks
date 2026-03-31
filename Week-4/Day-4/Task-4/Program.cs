using System;

class Order
{
    // Method with optional parameters
    public void CalculateFinalAmount(double price, int quantity, double discount = 0, double shipping = 50)
    {
        double subtotal = price * quantity;

        // Apply discount
        double discountAmount = subtotal * (discount / 100);
        double afterDiscount = subtotal - discountAmount;

        // Add shipping
        double finalAmount = afterDiscount + shipping;

        // Output
        Console.WriteLine("Subtotal: " + subtotal);
        Console.WriteLine("Discount Applied: " + discountAmount);
        Console.WriteLine("Shipping Charge: " + shipping);
        Console.WriteLine("Final Amount: " + finalAmount);
    }
}

class Program
{
    static void Main()
    {
        Order order = new Order();

        Console.Write("Enter Product Price: ");
        double price = Convert.ToDouble(Console.ReadLine());

        Console.Write("Enter Quantity: ");
        int quantity = Convert.ToInt32(Console.ReadLine());

        Console.WriteLine("\n--- Without Discount (Default) ---");
        order.CalculateFinalAmount(price, quantity);

        Console.WriteLine("\n--- With Discount Only ---");
        order.CalculateFinalAmount(price, quantity, 10);

        Console.WriteLine("\n--- With Discount and Custom Shipping ---");
        order.CalculateFinalAmount(price, quantity, 10, 100);
    }
}