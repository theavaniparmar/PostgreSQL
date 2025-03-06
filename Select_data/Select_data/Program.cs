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

        // method to get data 
        GetData(connString);
    }
    static void GetData(string connString)
    {
        try
        {
            using (var conn = new NpgsqlConnection(connString))
            {
                conn.Open();
                string selectQuery = "select id, name, email, salary from employees1";
                using (var cmd = new NpgsqlCommand(selectQuery, conn))
                {
                    using (var reader = cmd.ExecuteReader())
                    {
                        Console.WriteLine("Id| Name            | Salary");
                        Console.WriteLine("-----------------------------");

                        while (reader.Read())
                        {
                            int id = reader.GetInt32(0);
                            string name = reader.GetString(1);
                            decimal salary = reader.GetDecimal(2);

                            Console.WriteLine($"{id} | {name} | {salary}");
                        }
                    }
                }

            }
        } catch(Exception ex) { Console.Write(ex.ToString()); }s
    }
}


