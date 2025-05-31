using Microsoft.Practices.EnterpriseLibrary.Data;
using System;
using System.Data.Common;
using System.Data;
using DAL.Models;
using System.Collections.Generic;
using System.Data.SqlClient;

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
        public int? ModifiedBy { get; set; }
        public DateTime? ModifiedOn { get; set; }
        public int PageNumber { get; set; } = 1;
        public int PageSize { get; set; } = 10;
        public int TotalRecords { get; set; }
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

        public List<BookIssueModel> GetBookIssueList()
        {
            List<BookIssueModel> bookIssueList = new List<BookIssueModel>();

            try
            {
                DbCommand cmd = db.GetStoredProcCommand("BookIssueGetList");

                DataSet ds = db.ExecuteDataSet(cmd);

                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        BookIssueModel issue = new BookIssueModel
                        {
                            BookIssueId = Convert.ToInt32(row["BookIssueId"]),
                            MemberName = Convert.ToString(row["MemberName"]),
                            IssueDate = Convert.ToDateTime(row["IssueDate"]),
                            DueDate = Convert.ToDateTime(row["DueDate"]),
                            ReturnDate = row["ReturnDate"] != DBNull.Value ? (DateTime?)Convert.ToDateTime(row["ReturnDate"]) : null,
                            LibrarianName = Convert.ToString(row["LibrarianName"]),
                            IsActive = row["IsActive"] != DBNull.Value ? Convert.ToBoolean(row["IsActive"]) : false
                        };

                        bookIssueList.Add(issue);
                    }
                }
            }
            catch (Exception ex)
            {
                handler.InsertErrorLog(ex);
                throw new Exception("Error fetching book issue list: " + ex.Message);
            }

            return bookIssueList;
        }

        
        public bool SaveOrUpdate(BookIssueModel model)
        {
            try
            {
                DataTable dt = new DataTable();
                dt.Columns.Add("BookIssueDetailId", typeof(int));
                dt.Columns.Add("BookIssueId", typeof(int));
                dt.Columns.Add("BookId", typeof(int));
                dt.Columns.Add("Quantity", typeof(int));
                dt.Columns.Add("CreatedBy", typeof(int));
                dt.Columns.Add("ModifiedBy", typeof(int));

                foreach (var book in model.SelectedBooks)
                {
                    
                    int createdBy = book.BookIssueDetailId == 0 ? 1 : book.CreatedBy;
                    object modifiedBy = book.BookIssueDetailId > 0 ? (object)1 : DBNull.Value;

                    dt.Rows.Add(
                        book.BookIssueDetailId,
                        model.BookIssueId,
                        book.BookId,
                        book.Quantity,
                        createdBy,
                        modifiedBy
                    );
                }

                DbCommand cmd = db.GetStoredProcCommand("BookIssueUpsert");

                // BookIssueId input/output
                SqlParameter bookIssueIdParam = new SqlParameter("@BookIssueId", SqlDbType.Int)
                {
                    Direction = ParameterDirection.InputOutput,
                    Value = model.BookIssueId
                };

                cmd.Parameters.Add(bookIssueIdParam);

                // Main BookIssue parameters
                db.AddInParameter(cmd, "@MemberId", DbType.Int32, model.MemberId);
                db.AddInParameter(cmd, "@IssueDate", DbType.Date, model.IssueDate);
                db.AddInParameter(cmd, "@DueDate", DbType.Date, model.DueDate);
                db.AddInParameter(cmd, "@LibrarianId", DbType.Int32, model.LibrarianId);
                db.AddInParameter(cmd, "@CreatedBy", DbType.Int32, model.CreatedBy);
                db.AddInParameter(cmd, "@ModifiedBy", DbType.Int32, (object)model.ModifiedBy ?? DBNull.Value);

                // Add BookIssueDetails TVP
                SqlParameter tvpParam = new SqlParameter("@BookIssueDetails", SqlDbType.Structured)
                {
                    TypeName = "dbo.BookIssueDetailsMergeType",
                    Value = dt
                };
                cmd.Parameters.Add(tvpParam);

                int result = db.ExecuteNonQuery(cmd);

                // Output BookIssueId
                model.BookIssueId = Convert.ToInt32(bookIssueIdParam.Value);

                return true;
            }
            catch (Exception ex)
            {
                handler.InsertErrorLog(ex);
                throw new Exception("Error saving BookIssue and Details: " + ex.Message);
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
       


    }
}
