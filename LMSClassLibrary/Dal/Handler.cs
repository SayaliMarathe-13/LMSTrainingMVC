using System;
using System.Data;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;
using DAL.FileLogger;

namespace DAL.Dal
{
    public class Handler
    {
        private readonly Database db;
        public int ErrorLogId { get; set; }
        public string SourceMessage { get; set; }
        public string StackTrace { get; set; }
        public int? CreatedBy { get; set; } = 1;
        public DateTime? CreatedOn { get; set; }

        public Handler()
        {
            try
            {
                this.db = DatabaseFactory.CreateDatabase();
                //throw new Exception("Test exception to check file logging.");
            }
            catch (Exception ex)
            {
                Logger Logger = new Logger();
                Logger.Log(ex);
            }
        }

        public bool InsertErrorLog(Exception ex)
        {
            try
            {
                DbCommand com = this.db.GetStoredProcCommand("ErrorLogsInsert");

                this.db.AddInParameter(com, "SourceMessage", DbType.String, ex.Message);
                this.db.AddInParameter(com, "StackTrace", DbType.String, ex.StackTrace);

                if (this.CreatedBy > 0)
                    this.db.AddInParameter(com, "CreatedBy", DbType.Int32, CreatedBy);
                else
                    this.db.AddInParameter(com, "CreatedBy", DbType.Int32, CreatedBy);

                this.db.AddOutParameter(com, "ErrorLogId", DbType.Int32, 0);

                this.db.ExecuteNonQuery(com);

                this.ErrorLogId = Convert.ToInt32(this.db.GetParameterValue(com, "ErrorLogId"));
                Console.WriteLine("ErrorLogId: " + this.db.GetParameterValue(com, "ErrorLogId"));
                return true;
            }
            catch(Exception fileEx)
            {
                Logger logger = new Logger();
                logger.Log(fileEx);

                return false;
            }
        }


    }
}
