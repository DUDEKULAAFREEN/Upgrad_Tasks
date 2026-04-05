using LSP_ShapeCalculatorApp.Models;
using LSP_ShapeCalculatorApp.Services;

namespace LSP_ShapeCalculatorApp
{
    class Program
    {
        static void Main(string[] args)
        {
            AreaCalculator calculator = new AreaCalculator();

            // Rectangle
            var rectangle = new Rectangle { Width = 5, Height = 10 };
            calculator.PrintArea(rectangle);

            // Circle
            var circle = new Circle { Radius = 7 };
            calculator.PrintArea(circle);
        }
    }
}