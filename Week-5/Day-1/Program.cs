using System;

class BankAccount
{
    private string accountNumber;
    private double balance;

    public string AccountNumber
    {
        get { return accountNumber; }
        set { accountNumber = value; }
    }

    public double Balance
    {
        get { return balance; }
    }

    public void Deposit(double amount)
    {
        if (amount > 0)
        {
            balance += amount;
            Console.WriteLine("Deposited: " + amount);
            Console.WriteLine("Current Balance = " + balance);
        }
        else
        {
            Console.WriteLine("Invalid deposit amount!");
        }
    }

    public void Withdraw(double amount)
    {
        if (amount <= 0)
        {
            Console.WriteLine("Invalid withdrawal amount!");
        }
        else if (amount > balance)
        {
            Console.WriteLine("Insufficient balance!");
        }
        else
        {
            balance -= amount;
            Console.WriteLine("Withdrawn: " + amount);
            Console.WriteLine("Current Balance = " + balance);
        }
    }
}

class Program
{
    static void Main()
    {
        BankAccount account = new BankAccount();

        account.AccountNumber = "12345";

        account.Deposit(5000);
        account.Withdraw(2000);

        Console.WriteLine("Final Balance = " + account.Balance);
    }
}