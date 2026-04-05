using OCP_DiscountCalculatorApp.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OCP_DiscountCalculatorApp.Services
{
    public class DiscountCalculator
    {
        public double GetFinalPrice(double amount, IDiscountStrategy discountStrategy)
        {
            double discount = discountStrategy.CalculateDiscount(amount);
            return amount - discount;
        }
    }
}