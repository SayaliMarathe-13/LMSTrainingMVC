﻿using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.SqlClient;
using LMSClassLibrary.Models;

namespace DAL.Dal
{
    public class BookIssueDetails
    {
        private Handler handler = new Handler();
        private readonly Database db;
        public int BookIssueDetailId { get; set; }
        public List<int> BookIssueDetailIds { get; set; }
        public int BookIssueId { get; set; }
        public int BookId { get; set; }
        public int Quantity { get; set; }
        public bool IsActive { get; set; }
        public int CreatedBy { get; set; }
        public DateTime CreatedOn { get; set; }
        public int? ModifiedBy { get; set; }
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

        public List<BookIssueDetailsModel> GetIssuedBooksByIssueId()
        {
            List<BookIssueDetailsModel> issuedBooks = new List<BookIssueDetailsModel>();

            try
            {
                DbCommand cmd = db.GetStoredProcCommand("BookIssueDetailsGetByIssueId");
                Console.WriteLine("BookIssueId = " + this.BookIssueId);
                db.AddInParameter(cmd, "@BookIssueId", DbType.Int32, this.BookIssueId);

                using (IDataReader reader = db.ExecuteReader(cmd))
                {
                    Console.WriteLine("Field count: " + reader.FieldCount);
                    while (reader.Read())
                    {
                        BookIssueDetailsModel bookIssueDetailsModel = new BookIssueDetailsModel
                        {
                            BookIssueDetailId = Convert.ToInt32(reader["BookIssueDetailId"]),
                            BookIssueId = Convert.ToInt32(reader["BookIssueId"]),
                            BookId = Convert.ToInt32(reader["BookId"]),
                            BookName = Convert.ToString(reader["BookName"]),
                            ISBN = Convert.ToString(reader["ISBN"]),
                            PublisherName = Convert.ToString(reader["PublisherName"]),
                            CourseName = Convert.ToString(reader["CourseName"]),
                            Quantity = Convert.ToInt32(reader["Quantity"])
                        };

                        issuedBooks.Add(bookIssueDetailsModel);
                    }
                }
            }
            catch (Exception ex)
            {
                handler.InsertErrorLog(ex);
                throw new Exception("Error loading issued book details: " + ex.Message);
            }

            return issuedBooks;
        }


       


    }
}
