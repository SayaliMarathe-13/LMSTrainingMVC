using DAL.Models;
using LMSClassLibrary.Models;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;

namespace DAL.Dal
{
    public class Librarians
    {
        private Handler handler = new Handler();
        private readonly Database db;

        public int LibrarianId { get; set; }
        public string LibrarianName { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public bool IsActive { get; set; }
        public int CreatedBy { get; set; }
        public DateTime CreatedOn { get; set; }
        public int? ModifiedBy { get; set; }
        public DateTime? ModifiedOn { get; set; }

        public Librarians()
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

        public List<LibrariansModel> GetAllLibrarianNames()
        {
            List<LibrariansModel> list = new List<LibrariansModel>();

            try
            {
                DbCommand cmd = db.GetStoredProcCommand("LibrariansGetList");

                using (IDataReader reader = db.ExecuteReader(cmd))
                {
                    while (reader.Read())
                    {
                        list.Add(new LibrariansModel
                        {
                            LibrarianId = Convert.ToInt32(reader["LibrarianId"]),
                            LibrarianName = reader["LibrarianName"].ToString()
                        });
                    }
                }
            }
            catch (Exception ex)
            {
                handler.InsertErrorLog(ex);
                throw new Exception("Error fetching librarians: " + ex.Message);
            }

            return list;
        }
    }
}
