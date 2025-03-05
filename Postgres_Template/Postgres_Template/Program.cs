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

        try
        {
            using (var conn = new NpgsqlConnection(connString))
            {
                conn.Open();
                Console.WriteLine("✅ Connected to PostgreSQL successfully!");

                string createTableQuery = @"
                    CREATE TABLE IF NOT EXISTS employees (
                        id SERIAL PRIMARY KEY,
                        name VARCHAR(100) NOT NULL,
                        email VARCHAR(100) UNIQUE NOT NULL,
                        salary DECIMAL(10,2)
                    );
                ";

                using (var cmd = new NpgsqlCommand(createTableQuery, conn))
                {
                    cmd.ExecuteNonQuery();
                    Console.WriteLine("✅ Table 'employees' created successfully!");
                }
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"❌ Error: {ex.Message}");
        }
    }
}
