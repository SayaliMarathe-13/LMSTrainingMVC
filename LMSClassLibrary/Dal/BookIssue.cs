using Microsoft.Practices.EnterpriseLibrary.Data;
using System;
using System.Data.Common;
using System.Data;

namespace DAL.Dal
{
    public class BookIssue
    {
        private Handler handler = new Handler();
        private readonly Database db;
        public int BookIssueId { get; set; }
        public int MemberId { get; set; }
        public DateTime? IssueDate { get; set; }
        public DateTime? DueDate { get; set; }
        public DateTime? ReturnDate { get; set; }
        public int LibrarianId { get; set; }
        public bool IsActive { get; set; }
        public string CreatedBy { get; set; }
        public DateTime? CreatedOn { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime? ModifiedOn { get; set; }
        public BookIssue()
        {
            try
            {
                this.db = DatabaseFactory.CreateDatabase();
            }
            catch (Exception ex)
            {
                handler.InsertErrorLog(ex);
                throw new Exception("Database initialization failed: " + ex.Message);
            }
        }
        public bool Load()
        {
            try
            {
                if (this.BookIssueId != 0)
                {
                    DbCommand com = this.db.GetStoredProcCommand("BookIssueGetDetails");
                    this.db.AddInParameter(com, "BookIssueId", DbType.Int32, this.BookIssueId);

                    DataSet ds = this.db.ExecuteDataSet(com);
                    if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        DataTable dt = ds.Tables[0];
                        this.BookIssueId = Convert.ToInt32(dt.Rows[0]["BookIssueId"]);
                        this.MemberId = Convert.ToInt32(dt.Rows[0]["MemberId"]);

                        this.IssueDate = dt.Rows[0]["IssueDate"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(dt.Rows[0]["IssueDate"]);
                        this.DueDate = dt.Rows[0]["DueDate"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(dt.Rows[0]["DueDate"]);
                        this.ReturnDate = dt.Rows[0]["ReturnDate"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(dt.Rows[0]["ReturnDate"]);

                        this.LibrarianId = Convert.ToInt32(dt.Rows[0]["LibrarianId"]);
                        this.IsActive = Convert.ToBoolean(dt.Rows[0]["IsActive"]);
                        this.CreatedBy = Convert.ToString(dt.Rows[0]["CreatedBy"]);
                        this.CreatedOn = dt.Rows[0]["CreatedOn"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(dt.Rows[0]["CreatedOn"]);
                        this.ModifiedBy = Convert.ToString(dt.Rows[0]["ModifiedBy"]);
                        this.ModifiedOn = dt.Rows[0]["ModifiedOn"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(dt.Rows[0]["ModifiedOn"]);

                        return true;
                    }
                }
                return false;
            }
            catch (Exception ex)
            {
                handler.InsertErrorLog(ex);
                throw new Exception("Error loading book issue details: " + ex.Message);
            }
        }

    }
}
