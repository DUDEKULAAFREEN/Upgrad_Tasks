using System;

class BankAccount
{
    // Private field (Encapsulation)
    private double balance = 0;

    // Deposit method
    public void Deposit(double amount)
    {
        if (amount > 0)
        {
            balance += amount;
            Console.WriteLine("Deposited: " + amount);
        }
        else
        {
            Console.WriteLine("Invalid deposit amount!");
        }
    }

    // Withdraw method
    public void Withdraw(double amount)
    {
        if (amount <= balance)
        {
            balance -= amount;
            Console.WriteLine("Withdrawn: " + amount);
        }
        else
        {
            Console.WriteLine("Insufficient balance!");
        }
    }

    // Get balance method
    public double GetBalance()
    {
        return balance;
    }
}

class Program
{
    static void Main()
    {
        BankAccount account = new BankAccount();

        // Sample operations
        account.Deposit(1000);
        account.Withdraw(300);

        // Display balance
        Console.WriteLine("Current Balance = " + account.GetBalance());
    }
}