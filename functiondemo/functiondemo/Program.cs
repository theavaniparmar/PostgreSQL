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

        // call the function
        decimal salary = GetSalary(connString, "Avani Parmar");
        Console.WriteLine($"salary of Avani Parmar : {salary}");

    }

    static decimal GetSalary(string connstring, string name)
    {
        using (var conn = new NpgsqlConnection(connstring))
        {
            conn.Open();
            using (var cmd = new NpgsqlCommand("select get_salary(@p_name)", conn))
            {
                cmd.Parameters.AddWithValue("p_name", name);
                object result = cmd.ExecuteScalar();

                if (result == null || result == DBNull.Value)
                {
                    Console.WriteLine("Employee not found. Returning default salary.");
                    return 0;
                }
                else
                {
                    return Convert.ToDecimal(result);
                }
            }
        }
    }
}