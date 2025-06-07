using Microsoft.Practices.EnterpriseLibrary.Data;
using System;
using System.Data.Common;
using System.Data;
using DAL.Models;
using System.Collections.Generic;

namespace DAL.Dal
{
    public class BookIssueDocuments
    {
        public int DocumentId { get; set; }
        public int BookIssueId { get; set; }
        public string FileName { get; set; }
        public string FilePath { get; set; }
        public string ContentType { get; set; }
        public bool IsActive { get; set; } = true;
        public int UploadedBy { get; set; }
        public DateTime UploadedOn { get; set; } = DateTime.Now;
        public int? ModifiedBy { get; set; }
        public DateTime? ModifiedOn { get; set; }
        private readonly Database db;
        private Handler handler = new Handler();

        public BookIssueDocuments()
        {
            try
            {
                db = DatabaseFactory.CreateDatabase();
            }
            catch (Exception ex)
            {
                handler.InsertErrorLog(ex);
                throw new Exception("Database initialization failed: " + ex.Message);
            }
        }

        public void Insert(BookIssueDocuments doc)
        {
            try
            {
                using (DbCommand cmd = db.GetStoredProcCommand("BookIssueDocumentsInsert"))
                {
                    db.AddInParameter(cmd, "@BookIssueId", DbType.Int32, doc.BookIssueId);
                    db.AddInParameter(cmd, "@FileName", DbType.String, doc.FileName);
                    db.AddInParameter(cmd, "@FilePath", DbType.String, doc.FilePath);
                    db.AddInParameter(cmd, "@ContentType", DbType.String, doc.ContentType ?? (object)DBNull.Value);
                    db.AddInParameter(cmd, "@UploadedBy", DbType.Int32, doc.UploadedBy);

                    db.ExecuteNonQuery(cmd);
                }
            }
            catch (Exception ex)
            {
                handler.InsertErrorLog(ex);
                throw new Exception("Error while inserting document: " + ex.Message);
            }
        }
        public List<BookIssueDocuments> GetDocumentsByBookIssueId(int bookIssueId)
        {
            List<BookIssueDocuments> documents = new List<BookIssueDocuments>();

            try
            {
                using (DbCommand cmd = db.GetStoredProcCommand("BookIssueDocumentsGetList"))
                {
                    db.AddInParameter(cmd, "@BookIssueId", DbType.Int32, bookIssueId);

                    using (IDataReader reader = db.ExecuteReader(cmd))
                    {
                        while (reader.Read())
                        {
                            documents.Add(new BookIssueDocuments
                            {
                                DocumentId = Convert.ToInt32(reader["DocumentId"]),
                                BookIssueId = Convert.ToInt32(reader["BookIssueId"]),
                                FileName = reader["FileName"].ToString(),
                                FilePath = reader["FilePath"].ToString(),
                                ContentType = reader["ContentType"].ToString(),
                                UploadedBy = Convert.ToInt32(reader["UploadedBy"]),
                                UploadedOn = Convert.ToDateTime(reader["UploadedOn"])
                            });
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                handler.InsertErrorLog(ex);
                throw ex;
            }

            return documents;
        }
        public bool Delete(int documentId)
        {
            try
            {
                DbCommand com = this.db.GetStoredProcCommand("BookIssueDocumentsDelete");

                db.AddInParameter(com, "DocumentId", DbType.Int32, documentId);
                db.AddInParameter(com, "ModifiedBy", DbType.Int32, 1);

                db.ExecuteNonQuery(com);
                return true;
            }
            catch (Exception ex)
            {
                handler.InsertErrorLog(ex);
                throw;
            }
        }

        public BookIssueDocuments GetDocumentById(int documentId)
        {
            BookIssueDocuments document = null;

            try
            {
                using (DbCommand cmd = db.GetStoredProcCommand("BookIssueDocumentsGetById"))
                {
                    db.AddInParameter(cmd, "@DocumentId", DbType.Int32, documentId);

                    using (DataSet ds = db.ExecuteDataSet(cmd))
                    {
                        if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                        {
                            DataRow row = ds.Tables[0].Rows[0];

                            document = new BookIssueDocuments
                            {
                                DocumentId = Convert.ToInt32(row["DocumentId"]),
                                BookIssueId = Convert.ToInt32(row["BookIssueId"]),
                                FileName = Convert.ToString(row["FileName"]),
                                FilePath = Convert.ToString(row["FilePath"]),
                                ContentType = Convert.ToString(row["ContentType"]),
                            };
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                handler.InsertErrorLog(ex);
                throw;
            }

            return document;
        }

    }
}
