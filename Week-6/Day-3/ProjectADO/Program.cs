using System;
using ProductManagementADO.Data;
using ProductManagementADO.Models;

class Program
{
    static void Main()
    {
        ProductRepository repo = new ProductRepository();

        while (true)
        {
            Console.WriteLine("\n1. Add Product\n2. View Products\n3. Update Product\n4. Delete Product\n5. Exit");
            Console.Write("Choose option: ");
            int choice = int.Parse(Console.ReadLine());

            switch (choice)
            {
                case 1:
                    Product p = new Product();

                    Console.Write("Name: ");
                    p.ProductName = Console.ReadLine();

                    Console.Write("Category: ");
                    p.Category = Console.ReadLine();

                    Console.Write("Price: ");
                    p.Price = decimal.Parse(Console.ReadLine());

                    repo.AddProduct(p);
                    Console.WriteLine("Product Added!");
                    break;

                case 2:
                    var list = repo.GetAllProducts();
                    foreach (var item in list)
                    {
                        Console.WriteLine($"{item.ProductId} | {item.ProductName} | {item.Category} | {item.Price}");
                    }
                    break;

                case 3:
                    Product up = new Product();

                    Console.Write("Enter ID: ");
                    up.ProductId = int.Parse(Console.ReadLine());

                    Console.Write("New Name: ");
                    up.ProductName = Console.ReadLine();

                    Console.Write("New Category: ");
                    up.Category = Console.ReadLine();

                    Console.Write("New Price: ");
                    up.Price = decimal.Parse(Console.ReadLine());

                    repo.UpdateProduct(up);
                    Console.WriteLine("Updated!");
                    break;

                case 4:
                    Console.Write("Enter ID: ");
                    int id = int.Parse(Console.ReadLine());

                    repo.DeleteProduct(id);
                    Console.WriteLine("Deleted!");
                    break;

                case 5:
                    return;
            }
        }
    }
}