using System;
using System.Data;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Configuration;
using DAL.Models;
using System.Collections.Generic;

namespace DAL.Dal
{
   
    public class Books
    {
        private Handler handler=new Handler();
        private readonly Database db;
        public int BookId { get; set; }
        public string BookName { get; set; }
        public int PublisherId { get; set; }
        public String PublisherName { get; set; }
        public string ISBN { get; set; }
        public int TotalCopies { get; set; }
        public int CourseId { get; set; }
        public String CourseName { get; set; }
        public int SupplierId { get; set; }
        public String SupplierName { get; set; }
        public bool IsActive { get; set; }
        public int? CreatedBy { get; set; }
        public DateTime? CreatedOn { get; set; }
        public int? ModifiedBy { get; set; }
        public DateTime? ModifiedOn { get; set; }

        public Books()
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
        public List<BooksModel> GetSearchedBooksList(BooksModel model)
        {
            List<BooksModel> booksList = new List<BooksModel>();
            try
            {
                DbCommand com = db.GetStoredProcCommand("BooksGetList");
                if (string.IsNullOrEmpty(model.BookName))
                    db.AddInParameter(com, "BookName", DbType.String, DBNull.Value);
                else
                    db.AddInParameter(com, "BookName", DbType.String, model.BookName);

                if (model.PublisherId > 0)
                    db.AddInParameter(com, "PublisherId", DbType.Int32, model.PublisherId);
                else
                    db.AddInParameter(com, "PublisherId", DbType.Int32, DBNull.Value);

                if (model.SupplierId > 0)
                    db.AddInParameter(com, "SupplierId", DbType.Int32, model.SupplierId);
                else
                    db.AddInParameter(com, "SupplierId", DbType.Int32, DBNull.Value);

                if (model.CourseIds != null && model.CourseIds.Count > 0)
                {
                    string courseIds = string.Join(",", model.CourseIds);
                    db.AddInParameter(com, "CourseIds", DbType.String, courseIds);
                }
                else
                {
                    db.AddInParameter(com, "CourseIds", DbType.String, DBNull.Value);
                }


                db.AddInParameter(com, "PageNumber", DbType.Int32, model.PageNumber);

                db.AddInParameter(com, "PageSize", DbType.Int32, model.PageSize);


                DataSet ds = db.ExecuteDataSet(com);

                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        BooksModel book = new BooksModel
                        {
                            BookId = Convert.ToInt32(row["BookId"]),
                            BookName = Convert.ToString(row["BookName"]),
                            PublisherName = Convert.ToString(row["PublisherName"]),
                            ISBN = Convert.ToString(row["ISBN"]),
                            TotalCopies = Convert.ToInt32(row["TotalCopies"]),
                            CourseName = Convert.ToString(row["CourseName"]),
                            SupplierName = Convert.ToString(row["SupplierName"]),
                            IsActive = row["IsActive"] != DBNull.Value ? Convert.ToBoolean(row["IsActive"]) : false

                        };

                        booksList.Add(book);
                        //getting total records from first iteration only at once so booksList.Count==1
                        if (booksList.Count == 1 && row["TotalRecords"] != DBNull.Value)
                        {
                            model.TotalRecords = Convert.ToInt32(row["TotalRecords"]);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                handler.InsertErrorLog(ex);
                throw new Exception("Error fetching books list: " + ex.Message);
            }

            return booksList;
        }


        public bool Load()
        {
            try
            {
                if (this.BookId != 0)
                {
                    DbCommand com = this.db.GetStoredProcCommand("BooksGetDetails");
                    this.db.AddInParameter(com, "BookId", DbType.Int32, this.BookId);
                    DataSet ds = this.db.ExecuteDataSet(com);
                    if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        DataTable dt = ds.Tables[0];
                        this.BookId = Convert.ToInt32(dt.Rows[0]["BookId"]);
                        this.BookName = Convert.ToString(dt.Rows[0]["BookName"]);
                        this.ISBN = Convert.ToString(dt.Rows[0]["ISBN"]);
                        this.TotalCopies = Convert.ToInt32(dt.Rows[0]["TotalCopies"]);
                        this.PublisherId = Convert.ToInt32(dt.Rows[0]["PublisherId"]);
                        this.CourseId = Convert.ToInt32(dt.Rows[0]["CourseId"]);
                        this.SupplierId = Convert.ToInt32(dt.Rows[0]["SupplierId"]);
                        this.IsActive = Convert.ToBoolean(dt.Rows[0]["IsActive"]);

                        return true;
                    }
                }

                return false;
            }
            catch (Exception ex)
            {
                handler.InsertErrorLog(ex);
                throw new Exception("Error loading books list: " + ex.Message);
                return false;
            }
        }

        public bool Save()
        {
            if (this.BookId == 0)
            {
                return this.Insert();
            }
            else
            {
                if (this.BookId > 0)
                {
                    return this.Update();
                }
                else
                {
                    this.BookId = 0;
                    return false;
                }
            }
        }

        public bool Insert()
        {
            try
            {
                DbCommand com = this.db.GetStoredProcCommand("BooksInsert");

                // OUTPUT parameter
                this.db.AddOutParameter(com, "BookId", DbType.Int32, 1024);
                this.db.AddInParameter(com, "BookName", DbType.String, this.BookName);
                this.db.AddInParameter(com, "PublisherId", DbType.Int32, this.PublisherId);
                this.db.AddInParameter(com, "ISBN", DbType.String, this.ISBN);
                this.db.AddInParameter(com, "TotalCopies", DbType.Int32, this.TotalCopies);
                this.db.AddInParameter(com, "CourseId", DbType.Int32, this.CourseId);
                this.db.AddInParameter(com, "SupplierId", DbType.Int32, this.SupplierId);
                this.db.AddInParameter(com, "IsActive", DbType.Boolean, this.IsActive);

                if (this.CreatedBy > 0)
                    this.db.AddInParameter(com, "CreatedBy", DbType.Int32, this.CreatedBy);
                else
                    this.db.AddInParameter(com, "CreatedBy", DbType.Int32, DBNull.Value);

                if (this.CreatedOn > DateTime.MinValue)
                    this.db.AddInParameter(com, "CreatedOn", DbType.DateTime, this.CreatedOn);
                else
                    this.db.AddInParameter(com, "CreatedOn", DbType.DateTime, DBNull.Value);

                this.db.ExecuteNonQuery(com);

                this.BookId = Convert.ToInt32(this.db.GetParameterValue(com, "BookId"));
            }
            catch (Exception ex)
            {
                handler.InsertErrorLog(ex);
                throw new Exception("Error Inserting books: " + ex.Message);
                return false;
            }

            return this.BookId > 0;
        }

        private bool Update()
        {
            try
            {
              
                DbCommand com = this.db.GetStoredProcCommand("BooksUpdate");
                this.db.AddInParameter(com, "BookId", DbType.Int32, this.BookId);
                this.db.AddInParameter(com, "BookName", DbType.String, this.BookName);
                this.db.AddInParameter(com, "PublisherId", DbType.Int32, this.PublisherId);
                this.db.AddInParameter(com, "ISBN", DbType.String, this.ISBN);
                this.db.AddInParameter(com, "TotalCopies", DbType.Int32, this.TotalCopies);
                this.db.AddInParameter(com, "CourseId", DbType.Int32, this.CourseId);
                this.db.AddInParameter(com, "SupplierId", DbType.Int32, this.SupplierId);
                this.db.AddInParameter(com, "IsActive", DbType.Boolean, this.IsActive);
                this.db.AddInParameter(com, "ModifiedBy", DbType.Int32, this.ModifiedBy);
                this.db.AddInParameter(com, "ModifiedOn", DbType.DateTime, this.ModifiedOn);

                this.db.ExecuteNonQuery(com);
            }
            catch (Exception ex)
            {
                handler.InsertErrorLog(ex);
                throw new Exception("Error Updating books list: " + ex.Message);
                return false;
            }

            return true;
        }

        public bool Delete()
        {
            try
            {
                DbCommand com = this.db.GetStoredProcCommand("BooksDelete");

                this.db.AddInParameter(com, "BookId", DbType.Int32, this.BookId);
                this.db.AddInParameter(com, "ModifiedBy", DbType.Int32, this.ModifiedBy);
                this.db.AddInParameter(com, "ModifiedOn", DbType.DateTime, this.ModifiedOn);
                this.db.ExecuteNonQuery(com);
            }
            catch (Exception ex)
            {
                handler.InsertErrorLog(ex);
                throw new Exception("Error Deleting books: " + ex.Message);
                return false;
            }

            return true;
        }

       
    }
}

