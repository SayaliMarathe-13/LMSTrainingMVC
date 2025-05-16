using System;
using DAL.Models;
using System.Data;
using System.Data.Common;
using System.Collections.Generic;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Configuration;

namespace DAL.Dal
{
    public class Publishers
    {
        private readonly Database db;

        public Publishers()
        {
            try
            {
                this.db = DatabaseFactory.CreateDatabase();
            }
            catch (Exception ex)
            {
                throw new Exception("Database initialization failed: " + ex.Message);
            }
        }
        public List<PublishersModel> GetAllPublisherNames()
        {
            List<PublishersModel> list = new List<PublishersModel>();

            try
            {
                DbCommand cmd = db.GetStoredProcCommand("PublishersGetList");

                using (IDataReader reader = db.ExecuteReader(cmd))
                {
                    while (reader.Read())
                    {
                        list.Add(new PublishersModel
                        {
                            PublisherId = Convert.ToInt32(reader["PublisherId"]),
                            PublisherName = reader["PublisherName"].ToString()
                        });
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error fetching publishers: " + ex.Message);
            }

            return list;
        }
    }

}

