using LSP_ShapeCalculatorApp.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LSP_ShapeCalculatorApp.Services
{
    public class AreaCalculator
    {
        public void PrintArea(IShape shape)
        {
            Console.WriteLine("Area: " + shape.CalculateArea());
        }
    }
}
