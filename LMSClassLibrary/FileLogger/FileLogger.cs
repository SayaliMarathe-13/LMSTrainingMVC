using System;
using System.IO;
using System.Configuration;

namespace DAL.FileLogger
{
    public class Logger
    {
        string logFilePath = ConfigurationManager.AppSettings["LogFilePath"];

        public void Log(Exception ex)
        {
            try
            {
                string directoryPath = Path.GetDirectoryName(logFilePath);
                if (!Directory.Exists(directoryPath))
                {
                    Console.WriteLine("Log file path: " + logFilePath);

                    Directory.CreateDirectory(directoryPath); 
                }

                using (StreamWriter writer = new StreamWriter(logFilePath, true))
                {
                    writer.WriteLine("----- Error Logged at: " + DateTime.Now + " -----");
                    writer.WriteLine("Message    : " + ex.Message);
                    writer.WriteLine("StackTrace : " + ex.StackTrace);
                    writer.WriteLine("--------------------------------------------------");
                    writer.WriteLine(); 
                }
            }
            catch (Exception loggingEx)
            {
                Console.WriteLine("Error while logging to file: " + loggingEx.Message);
            }
        }
    }
}
