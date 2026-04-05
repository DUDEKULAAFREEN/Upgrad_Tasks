using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OCP_DiscountCalculatorApp.Interfaces
{
    public interface IDiscountStrategy
    {
        double CalculateDiscount(double amount);
    }
}
