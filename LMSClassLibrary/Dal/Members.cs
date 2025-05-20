using DAL.Dal;
using LMSClassLibrary.Models;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LMSClassLibrary.Dal
{
    public class Members
    {
        private Handler handler = new Handler();
        private readonly Database db;
        public int MemberId { get; set; }
        public string MemberName { get; set; }
        public string Email { get; set; }
        public DateTime DOB { get; set; }
        public string Contact { get; set; }
        public int DepartmentId { get; set; }
        public int MemberTypeId { get; set; }
        public bool IsActive { get; set; }
        public int CreatedBy { get; set; }
        public DateTime CreatedOn { get; set; }
        public int? ModifiedBy { get; set; }
        public DateTime? ModifiedOn { get; set; }

        public Members()
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

        public List<MembersModel> GetAllMemberNames()
        {
            List<MembersModel> list = new List<MembersModel>();

            try
            {
                DbCommand cmd = db.GetStoredProcCommand("MembersGetList"); 

                using (IDataReader reader = db.ExecuteReader(cmd))
                {
                    while (reader.Read())
                    {
                        list.Add(new MembersModel
                        {
                            MemberId = Convert.ToInt32(reader["MemberId"]),
                            MemberName = reader["MemberName"].ToString()
                        });
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error fetching members: " + ex.Message);
            }

            return list;
        }

    }
}
