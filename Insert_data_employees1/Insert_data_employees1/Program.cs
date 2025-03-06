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
        InsertEmployee(connString, "Avani", "abc@gmail.com", 85000);

    }
    static void InsertEmployee(string connString, string name, string email, decimal salary)
    {
        using (var conn = new NpgsqlConnection(connString))
        {
            conn.Open();

            string insertQuery = "insert into employees1(name, email, salary) values (@p_name, @p_email, @p_salary)";

            using (var cmd = new NpgsqlCommand(insertQuery, conn))
            {
                cmd.Parameters.AddWithValue("p_name", name);
                cmd.Parameters.AddWithValue("p_email", email);
                cmd.Parameters.AddWithValue("p_salary", salary);

                int result = cmd.ExecuteNonQuery();

                if (result > 0)
                {
                    Console.WriteLine($"Employee {name} inserted successfully");
                }
                else
                {
                    Console.WriteLine("Insertion failed");
                }


            }

        }
    }
}

        

