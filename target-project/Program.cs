using System;
using System.Text.Json;

namespace ProblemProject
{
    static class Program
    {
        static int Main(string[] args)
        {
            var msg = "Hello, World!";
            Console.WriteLine(JsonSerializer.Serialize<string>(msg));
            return 0;
        }
    }
}
