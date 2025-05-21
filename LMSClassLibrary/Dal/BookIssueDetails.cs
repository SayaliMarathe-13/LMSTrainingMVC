using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace DAL.Dal
{
    public class BookIssueDetails
    {
        private Handler handler = new Handler();
        private readonly Database db;
        public int BookIssueDetailId { get; set; }
        public int BookIssueId { get; set; }
        public int BookId { get; set; }
        public bool IsActive { get; set; }
        public int CreatedBy { get; set; }
        public DateTime CreatedOn { get; set; }
        public int ModifiedBy { get; set; }
        public DateTime? ModifiedOn { get; set; }
        public BookIssueDetails()
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
            if (this.BookIssueDetailId == 0)
            {
                return this.Insert();
            }
            else if (this.BookIssueDetailId > 0)
            {
                return this.Update();
            }
            else
            {
                this.BookIssueDetailId = 0;
                return false;
            }
        }

        public bool Insert()
        {
            try
            {
                DbCommand com = this.db.GetStoredProcCommand("BookIssueDetailsInsert");

                // OUTPUT parameter
                this.db.AddOutParameter(com, "BookIssueDetailId", DbType.Int32, 1024);

                this.db.AddInParameter(com, "BookIssueId", DbType.Int32, this.BookIssueId);
                this.db.AddInParameter(com, "BookId", DbType.Int32, this.BookId);
                this.db.AddInParameter(com, "IsActive", DbType.Boolean, this.IsActive);
                this.db.AddInParameter(com, "CreatedBy", DbType.Int32, this.CreatedBy);

                this.db.ExecuteNonQuery(com);

                this.BookIssueDetailId = Convert.ToInt32(this.db.GetParameterValue(com, "BookIssueDetailId"));
            }
            catch (Exception ex)
            {
                handler.InsertErrorLog(ex);
                throw new Exception("Error inserting book issue detail: " + ex.Message);
            }

            return this.BookIssueDetailId > 0;
        }

        private bool Update()
        {
            try
            {
                DbCommand com = this.db.GetStoredProcCommand("BookIssueDetailsUpdate");

                this.db.AddInParameter(com, "BookIssueDetailId", DbType.Int32, this.BookIssueDetailId);
                this.db.AddInParameter(com, "BookIssueId", DbType.Int32, this.BookIssueId);
                this.db.AddInParameter(com, "BookId", DbType.Int32, this.BookId);
                this.db.AddInParameter(com, "IsActive", DbType.Boolean, this.IsActive);
                this.db.AddInParameter(com, "ModifiedBy", DbType.Int32, this.ModifiedBy);
                this.db.AddInParameter(com, "ModifiedOn", DbType.DateTime, this.ModifiedOn);

                this.db.ExecuteNonQuery(com);
            }
            catch (Exception ex)
            {
                handler.InsertErrorLog(ex);
                throw new Exception("Error updating BookIssueDetail: " + ex.Message);
            }

            return true;
        }

    }
}
