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
        public int CreatedBy { get; set; }
        public DateTime? CreatedOn { get; set; }
        public int ModifiedBy { get; set; }
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
        public bool Save()
        {
            if (this.BookIssueId == 0)
            {
                return this.Insert();
            }
            else if (this.BookIssueId > 0)
            {
                return this.Update();
            }
            else
            {
                this.BookIssueId = 0;
                return false;
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
                        this.CreatedBy = Convert.ToInt32(dt.Rows[0]["CreatedBy"]);
                        this.CreatedOn = dt.Rows[0]["CreatedOn"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(dt.Rows[0]["CreatedOn"]);
                        this.ModifiedBy = Convert.ToInt32(dt.Rows[0]["ModifiedBy"]);
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
        public bool Insert()
        {
            try
            {
                DbCommand com = this.db.GetStoredProcCommand("BookIssueInsert");

                // OUTPUT parameter
                this.db.AddOutParameter(com, "BookIssueId", DbType.Int32, 1024);

                this.db.AddInParameter(com, "MemberId", DbType.Int32, this.MemberId);
                this.db.AddInParameter(com, "IssueDate", DbType.Date, this.IssueDate);
                this.db.AddInParameter(com, "DueDate", DbType.Date, this.DueDate);

                if (this.ReturnDate.HasValue)
                    this.db.AddInParameter(com, "ReturnDate", DbType.Date, this.ReturnDate.Value);
                else
                    this.db.AddInParameter(com, "ReturnDate", DbType.Date, DBNull.Value);

                this.db.AddInParameter(com, "LibrarianId", DbType.Int32, this.LibrarianId);
                this.db.AddInParameter(com, "IsActive", DbType.Boolean, this.IsActive);
                this.db.AddInParameter(com, "CreatedBy", DbType.Int32, this.CreatedBy);

                this.db.ExecuteNonQuery(com);

                this.BookIssueId = Convert.ToInt32(this.db.GetParameterValue(com, "BookIssueId"));
            }
            catch (Exception ex)
            {
                handler.InsertErrorLog(ex);
                throw new Exception("Error inserting book issue: " + ex.Message);
            }

            return this.BookIssueId > 0;
        }
        private bool Update()
        {
            try
            {
                DbCommand com = this.db.GetStoredProcCommand("BookIssueUpdate");

                this.db.AddInParameter(com, "BookIssueId", DbType.Int32, this.BookIssueId);
                this.db.AddInParameter(com, "MemberId", DbType.Int32, this.MemberId);
                this.db.AddInParameter(com, "IssueDate", DbType.Date, this.IssueDate);
                this.db.AddInParameter(com, "DueDate", DbType.Date, this.DueDate);

                if (this.ReturnDate.HasValue)
                    this.db.AddInParameter(com, "ReturnDate", DbType.Date, this.ReturnDate.Value);
                else
                    this.db.AddInParameter(com, "ReturnDate", DbType.Date, DBNull.Value);

                this.db.AddInParameter(com, "LibrarianId", DbType.Int32, this.LibrarianId);
                this.db.AddInParameter(com, "IsActive", DbType.Boolean, this.IsActive);
                this.db.AddInParameter(com, "ModifiedBy", DbType.Int32, this.ModifiedBy);
                this.db.AddInParameter(com, "ModifiedOn", DbType.DateTime, this.ModifiedOn);

                this.db.ExecuteNonQuery(com);
            }
            catch (Exception ex)
            {
                handler.InsertErrorLog(ex);
                throw new Exception("Error updating BookIssue: " + ex.Message);
            }

            return true;
        }


    }
}
