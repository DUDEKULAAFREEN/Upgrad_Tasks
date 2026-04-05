using System;
using OCP_DiscountCalculatorApp.Services;

namespace OCP_DiscountCalculatorApp
{
    class Program
    {
        static void Main(string[] args)
        {
            DiscountCalculator calculator = new DiscountCalculator();

            double amount = 1000;

            // Regular Customer
            var regular = new RegularCustomerDiscount();
            Console.WriteLine("Regular Customer Final Price: " +
                calculator.GetFinalPrice(amount, regular));

            // Premium Customer
            var premium = new PremiumCustomerDiscount();
            Console.WriteLine("Premium Customer Final Price: " +
                calculator.GetFinalPrice(amount, premium));

            // VIP Customer
            var vip = new VipCustomerDiscount();
            Console.WriteLine("VIP Customer Final Price: " +
                calculator.GetFinalPrice(amount, vip));
        }
    }
}