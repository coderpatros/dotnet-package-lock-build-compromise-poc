namespace System.Text.Json
{
    public class JsonSerializerOptions {}

    public static class JsonSerializer
    {
        public static string Serialize<T>(T obj, JsonSerializerOptions options)
        {
            return "\"Goodbye, World!\"";
        }
    }
}