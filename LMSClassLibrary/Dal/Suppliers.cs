using System;
using DAL.Models;
using System.Data;
using System.Data.Common;
using System.Collections.Generic;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Configuration;

namespace DAL.Dal
{
    public class Suppliers
    {
        private readonly Database db;

        public Suppliers()
        {
            db = DatabaseFactory.CreateDatabase();
        }

        public List<SuppliersModel> GetAllSupplierNames()
        {
            List<SuppliersModel> list = new List<SuppliersModel>();
            DbCommand cmd = db.GetStoredProcCommand("SuppliersGetList");

            using (IDataReader reader = db.ExecuteReader(cmd))
            {
                while (reader.Read())
                {
                    list.Add(new SuppliersModel
                    {
                        SupplierId = Convert.ToInt32(reader["SupplierId"]),
                        SupplierName = reader["SupplierName"].ToString()
                    });
                }
            }
            return list;
        }
    }

}
