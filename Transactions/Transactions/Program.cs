using System;
using System.IO;
using Microsoft.Extensions.Configuration;
using Npgsql;
using Npgsql.Replication.PgOutput.Messages;

class Program
{
    static void Main()
    {
        // Load the connection string from appsettings.json
        var config = new ConfigurationBuilder()
            .SetBasePath(Directory.GetCurrentDirectory())
            .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
            .Build();

        string connString = config.GetConnectionString("PostgresConnection");

        InsertEmployeesWithTrans(connString);

    }
    static void InsertEmployeesWithTrans(string connstring)
    {
        using (var conn = new NpgsqlConnection(connstring))
        {
            conn.Open();
            using (var trans = conn.BeginTransaction())
            {
                try
                {
                    using (var cmd = new NpgsqlCommand())
                    {
                        cmd.Connection = conn;
                        cmd.Transaction = trans;

                        cmd.CommandText = "insert into employees (name, salary) values (@pname, @psalary)";
                        cmd.Parameters.AddWithValue("pname", "abc");
                        cmd.Parameters.AddWithValue("psalary", 20000);
                        cmd.ExecuteNonQuery();
                        cmd.Parameters.Clear();

                        trans.Commit();
                        Console.WriteLine("employees inserted successfully");
                    }
                }
                catch (Exception ex)
                {
                    trans.Rollback();
                    Console.WriteLine("transaction failed");
                    Console.WriteLine(ex.ToString());
                }
            }
        }
    }
}

