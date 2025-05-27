using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.SqlClient;

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
        public List<int> BookIds { get; set; }
        public List<int> Quantities { get; set; }
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
                return Insert();
            }
            else if (this.BookIssueDetailId > 0)
            {
                return Update();
            }
            else
            {
                this.BookIssueDetailId = 0;
                return false;
            }
        }

        private bool Insert()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("BookId", typeof(int));        
            dt.Columns.Add("BookIssueId", typeof(int));    
            dt.Columns.Add("Quantity", typeof(int));
            dt.Columns.Add("IsActive", typeof(bool));
            dt.Columns.Add("CreatedBy", typeof(int));
            dt.Columns.Add("CreatedOn", typeof(DateTime));

            for (int i = 0; i < BookIds.Count; i++)
            {
                int bookId = BookIds[i];
                int quantity = (Quantities != null && Quantities.Count > i) ? Quantities[i] : 1;

                dt.Rows.Add(bookId, BookIssueId, quantity, IsActive, CreatedBy, CreatedOn);
            }


            DbCommand cmd = db.GetStoredProcCommand("BookIssueDetailsInsert");

            SqlParameter param = new SqlParameter("@BookIssueDetails", SqlDbType.Structured)
            {
                TypeName = "BookIssueDetailsType",
                Value = dt
            };

            cmd.Parameters.Add(param);

            int result = db.ExecuteNonQuery(cmd);

            return result > 0;
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
