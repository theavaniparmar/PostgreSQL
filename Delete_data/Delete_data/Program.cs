using Microsoft.Extensions.Configuration;
using Npgsql;
using System;
using System.IO;

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

        //add a method to delete employee by their id

        Console.WriteLine("Enter a employee ID you want to delete:");

        if (int.TryParse(Console.ReadLine(), out int emp_id))
        {
            DeleteEmployee(connString, emp_id);
        }
        else
        {
            Console.WriteLine("Invalid Input, please give valid ID...");
        }
    }

    static void DeleteEmployee(string connString, int emp_id)
    {
        using(var conn = new NpgsqlConnection(connString))
        {
            conn.Open();

            string deleteQuery = "delete from employees where id = @p_id";

            using(var conn2 = new NpgsqlCommand(deleteQuery, conn)) 
            {
                conn2.Parameters.AddWithValue("p_id", emp_id);
                int result = conn2.ExecuteNonQuery();

                if (result >= 0)
                {
                    Console.WriteLine($" Employee with {emp_id} deleted successfully... ");
                }
                else
                {
                    Console.WriteLine("Error");
                }
            }
        }
    }
}
