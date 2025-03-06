using System;
using System.IO;
using Microsoft.Extensions.Configuration;
using Npgsql;

class Program
{
    static void Main()
    {
        // Load configuration from appsettings.json
        var config = new ConfigurationBuilder()
            .SetBasePath(Directory.GetCurrentDirectory())
            .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
            .Build();

        string connString = config.GetConnectionString("PostgresConnection");

        //insert employees
        InsertEmployee(connString, "Avani", "abc@gmail.com", 85000.80);

    }
    static void InsertEmployee(string connString, string name, string email, decimal salary)
    {
        using (var conn = new NpgsqlConnection(connString))

    }

        

