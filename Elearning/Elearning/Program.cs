using System;
using System.IO;
using Microsoft.Extensions.Configuration;
using Npgsql;

class Program
{
    static void Main()
    {
        // Load configuration
        var config = new ConfigurationBuilder()
            .SetBasePath(Directory.GetCurrentDirectory()) // Ensure System.IO is used
            .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
            .Build();

        // Retrieve connection string
        string connString = config.GetConnectionString("PostgresConnection");

        // Print for verification
        Console.WriteLine($"Connection String: {connString}");

        try
        {
            using (var conn = new NpgsqlConnection(connString))
            {
                conn.Open();
                Console.WriteLine("Connected to PostgreSQL successfully!");

                using (var cmd = new NpgsqlCommand("SELECT * FROM users", conn))
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Console.WriteLine($"ID: {reader["id"]}, Name: {reader["name"]}, Password: {reader["password"]}");
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error: {ex.Message}");
        }
    }
}

    

