using System;

// Custom Exception Class
class InsufficientBalanceException : Exception
{
    public InsufficientBalanceException(string message) : base(message)
    {
    }
}

// BankAccount class
class BankAccount
{
    private double balance;

    // Constructor to set initial balance
    public BankAccount(double balance)
    {
        this.balance = balance;
    }

    // Withdraw method
    public void Withdraw(double amount)
    {
        if (amount > balance)
        {
            // Throw custom exception
            throw new InsufficientBalanceException("Error: Withdrawal amount exceeds available balance");
        }
        else
        {
            balance -= amount;
            Console.WriteLine("Withdrawal Successful. Remaining Balance = " + balance);
        }
    }
}

class Program
{
    static void Main()
    {
        Console.Write("Enter Balance: ");
        double balance = Convert.ToDouble(Console.ReadLine());

        Console.Write("Enter Withdrawal Amount: ");
        double amount = Convert.ToDouble(Console.ReadLine());

        BankAccount account = new BankAccount(balance);

        try
        {
            account.Withdraw(amount);
        }
        catch (InsufficientBalanceException ex)
        {
            Console.WriteLine(ex.Message);
        }
        finally
        {
            Console.WriteLine("Transaction completed.");
        }
    }
}