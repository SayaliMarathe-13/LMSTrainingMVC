using System;
using DAL.Models;
using System.Data;
using System.Data.Common;
using System.Collections.Generic;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Configuration;

namespace DAL.Dal
{
    public class Courses
    {
        private readonly Database db;

        public Courses()
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

        public List<CoursesModel> GetAllCourseNames()
        {
            List<CoursesModel> list = new List<CoursesModel>();

            try
            {
                DbCommand cmd = db.GetStoredProcCommand("CoursesGetList");

                using (IDataReader reader = db.ExecuteReader(cmd))
                {
                    while (reader.Read())
                    {
                        list.Add(new CoursesModel
                        {
                            CourseId = Convert.ToInt32(reader["CourseId"]),
                            CourseName = reader["CourseName"].ToString()
                        });
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error fetching courses: " + ex.Message);
            }

            return list;
        }
    }
}
