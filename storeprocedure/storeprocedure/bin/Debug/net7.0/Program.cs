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
            .SetBasePath(Directory.GetCurrentDirectory())
            .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
            .Build();

        string connString = config.GetConnectionString("PostgresConnection");

        // Call the stored procedure
        InsertEmployee(connString, "Avani Parmar", 50000.00m);
    }

    static void InsertEmployee(string connString, string name, decimal salary)
    {
        using (var conn = new NpgsqlConnection(connString))
        {
            conn.Open();

            using (var cmd = new NpgsqlCommand("CALL insert_employee(@p_name, @p_salary)", conn))
            {
                cmd.Parameters.AddWithValue("p_name", name);
                cmd.Parameters.AddWithValue("p_salary", salary);

                cmd.ExecuteNonQuery();
                Console.WriteLine($"Employee {name} inserted successfully.");
            }
        }
    }
}
